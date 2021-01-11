import 'package:app/proto/models.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

// Error: [ERROR:flutter/lib/ui/ui_dart_state.cc(177)] Unhandled Exception:
//          gRPC Error (code: 14, codeName: UNAVAILABLE,
//          message: Error connecting: HandshakeException: Handshake error in client 
//          (OS Error: WRONG_VERSION_NUMBER(tls_record.cc:242)), details: null)

class ViewModelTodoList extends ChangeNotifier {
  TodoServiceClient _client;
  List<ViewModelTodo> _todos = [];
  ViewModelTodo _form;

  ViewModelTodoList() {
    final channel = ClientChannel(
      "localhost",
      port: 50051,
      options: ChannelOptions(
        credentials: ChannelCredentials
            .insecure(), // Note: This is needed to avoid TLS error added above and broken to many lines
      ),
    );
    _client = TodoServiceClient(channel);
    setForm(null);
    fetchTodos();
  }

  ViewModelTodo get form {
    return _form;
  }

  void setForm(ViewModelTodo todo) {
    if (todo == null) {
      _form = ViewModelTodo(_client, Todo());
    } else {
      _form = todo;
    }

    notifyListeners();
  }

  Future<void> fetchTodos() async {
    final result = await _client.getAll(TodoFilter());
    print('===============================');
    print(result.results.length);
    print('===============================');
    _todos = result.results.map((item) {
      return ViewModelTodo(_client, item);
    }).toList();

    _todos.sort((ViewModelTodo a, ViewModelTodo b) {
      return a.createAt.compareTo(b.createAt);
    });
    notifyListeners();
  }

  List<ViewModelTodo> get todos {
    return List<ViewModelTodo>.from(_todos);
  }

  int get count {
    print('Count: ${_todos.length}');
    return _todos.length;
  }
}

class ViewModelTodo extends ChangeNotifier {
  Todo _model;
  TodoServiceClient _client;
  ViewModelTodo(TodoServiceClient client, Todo model)
      : _client = client,
        _model = model;

  String get uid {
    return _model.uid;
  }

  String get body {
    return _model.body;
  }

  set body(String val) {
    _model.body = val;
    notifyListeners();
  }

  bool get done {
    return _model.done;
  }

  set done(bool val) {
    _model.done = val;
    notifyListeners();
  }

  DateTime get createAt {
    return DateTime.fromMillisecondsSinceEpoch((_model.createAt.toInt() / 1000).floor());
  }

  bool get isFormValid {
    return _model.body.trim().length > 0;
  }

  Future<bool> save() async {
    if (_model.uid == '') {
      return await _create();
    } else {
      return await _update();
    }
  }

  Future<bool> delete() async {
    final result = await _client.remove(TodoParams(uid: _model.uid));
    return result.success;
  }

  Future<bool> _create() async {
    final result = await _client.add(_model);
    return result.success;
  }

  Future<bool> _update() async {
    final result = await _client.update(_model);
    return result.success;
  }
}
