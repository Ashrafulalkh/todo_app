import 'package:flutter/material.dart';
import 'package:todo_app/entities/todo.dart';
import 'package:todo_app/ui/widgets/empty_list_widgets.dart';

class AddNewTodoScreen extends StatefulWidget {
  const AddNewTodoScreen({super.key, required this.onAddTodo});

  final Function(Todo) onAddTodo;

  @override
  State<AddNewTodoScreen> createState() => _AddNewTodoState();
}

class _AddNewTodoState extends State<AddNewTodoScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Title',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter Your Title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _descriptionTEController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 250,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter Your Description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Todo todo = Todo(
                      _titleTEController.text.trim(),
                      _descriptionTEController.text.trim(),
                      DateTime.now(),
                    );
                    widget.onAddTodo(todo);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Add Todo',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
