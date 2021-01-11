import 'package:app/view_models/todos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormTodo extends StatefulWidget {
  @override
  _FormTodoState createState() => _FormTodoState();
}

class _FormTodoState extends State<FormTodo> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final vmList = Provider.of<ViewModelTodoList>(context);
    final vm = Provider.of<ViewModelTodo>(context);

    if (_controller.text != vmList.form.body) {
      _controller.text = vmList.form.body;
    }

    return Container(
      child: Column(
        children: [
          Container(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Body',
              ),
              onChanged: (val) => vm.body = val,
              onFieldSubmitted: !vm.isFormValid
                  ? null
                  : (val) async {
                      vm.body = val;
                      // Assume it will always be valid for progress purposes
                      final saved = await vm.save();
                      if (!saved) {
                        print('============================================');
                        print('Could not save the todo.');
                        print('============================================');
                        return;
                      }

                      vmList.setForm(null); // Reset the form
                      vmList.fetchTodos(); // Update the list of todos
                    },
            ),
          ),
        ],
      ),
    );
  }
}
