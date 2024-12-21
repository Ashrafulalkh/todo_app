import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';

class AddNewTodoScreen extends StatefulWidget {
  const AddNewTodoScreen({super.key, required this.onAddTodo});

  final Function(Todo) onAddTodo;

  @override
  State<AddNewTodoScreen> createState() => _AddNewTodoState();
}

class _AddNewTodoState extends State<AddNewTodoScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add New Todo',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 15,),
                      TextFormField(
                        controller: _titleTEController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                        ),
                        autovalidateMode: AutovalidateMode.disabled,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter Your Title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _descriptionTEController,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                        ),
                        autovalidateMode: AutovalidateMode.disabled,
                        maxLines: 6,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter Your Description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Add Todo',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
