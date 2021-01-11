package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"time"

	"github.com/google/uuid"
	"github.com/tithamane/todo_go_flutter/api/proto"
	"google.golang.org/grpc"
)

const BaseErrorMessage = "Focus on testing GRPC and go, not breaking the app"

func main() {
	fmt.Println("Starting server")
	address := "0.0.0.0:50051"
	lis, err := net.Listen("tcp", address)

	if err != nil {
		log.Fatalf("Error %s", err)
	}

	log.Printf("Server is listening on %v\n", address)

	s := grpc.NewServer()
	proto.RegisterTodoServiceServer(s, NewTodoApp())

	s.Serve(lis)
}

// NewTodoApp create a app for handling todos.
func NewTodoApp() *TodoApp {
	return &TodoApp{todos: make(map[string]*proto.Todo)}
}

// TodoApp that is build with GRPC.
type TodoApp struct {
	todos map[string]*proto.Todo
}

// NewTodo creates a new todo.
func NewTodo(body string, done bool) *proto.Todo {
	uid, _ := uuid.NewUUID()
	now := time.Now().Unix()

	return &proto.Todo{
		Uid:      uid.String(),
		Body:     body,
		Done:     done,
		CreateAt: now,
	}
}

// Get returns a single Todo by uid.
func (t *TodoApp) Get(ctx context.Context, request *proto.TodoParams) (*proto.Todo, error) {
	log.Printf("Getting todo with uid: %s\n", request.Uid)
	todo, ok := t.todos[request.Uid]
	if !ok {
		panic(BaseErrorMessage)
	}

	return todo, nil
}

// GetAll returns all the Todos.
func (t *TodoApp) GetAll(ctx context.Context, request *proto.TodoFilter) (*proto.TodoList, error) {
	log.Printf("Getting all todos (%d)\n", len(t.todos))
	var items []*proto.Todo

	for _, todo := range t.todos {
		items = append(items, todo)
	}

	res := &proto.TodoList{Results: items, Count: uint32(len(items))}

	return res, nil
}

// Add a todo.
func (t *TodoApp) Add(ctx context.Context, request *proto.Todo) (*proto.RequestResult, error) {
	log.Println("Adding a todo")
	newTodo := NewTodo(request.Body, request.Done)
	t.todos[newTodo.Uid] = newTodo

	return &proto.RequestResult{Success: true}, nil
}

// Remove a todo.
func (t *TodoApp) Remove(ctx context.Context, request *proto.TodoParams) (*proto.RequestResult, error) {
	log.Println("Removing a todo")
	_, ok := t.todos[request.Uid]
	if !ok {
		panic(BaseErrorMessage)
	}

	delete(t.todos, request.Uid)
	return &proto.RequestResult{Success: true}, nil
}

// Update a todo.
func (t *TodoApp) Update(ctx context.Context, request *proto.Todo) (*proto.RequestResult, error) {
	log.Println("Updating a todo")
	_, ok := t.todos[request.Uid]
	if !ok {
		panic(BaseErrorMessage)
	}

	todo, _ := t.todos[request.Uid]
	todo.Body = request.Body
	todo.Done = request.Done
	return &proto.RequestResult{Success: true}, nil
}
