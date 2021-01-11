import 'package:app/forms.dart';
import 'package:app/view_models/todos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewTodo extends StatefulWidget {
  @override
  _ViewTodoState createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {
  @override
  Widget build(BuildContext context) {
    final vmList = Provider.of<ViewModelTodoList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 5,
                  color: Colors.red,
                )),
                child: ListView.builder(
                    itemCount: vmList.count,
                    itemBuilder: (context, index) {
                      final todo = vmList.todos[index];
                      print('=> $todo: ${todo.uid} -> ${todo.body}');
                      return ListTile(
                        key: Key(todo.uid),
                        title: Text(
                          todo.body,
                          style: TextStyle(
                              decoration: todo.done
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: todo.done,
                              onChanged: (val) async {
                                // Question: Can part of this logic move into the view model?
                                todo.done = val;
                                await todo.save();
                                vmList.fetchTodos();
                              },
                            ),
                            // No delete validation, it's a waste of time for now
                            GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () async {
                                await todo.delete();
                                vmList.fetchTodos();
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: ChangeNotifierProvider.value(
                value: vmList.form,
                child: FormTodo(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
