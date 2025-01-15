import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/models/user/user_model.dart';
import 'package:todo_app/ui/state_holders/add%20new%20todo/add_new_todo_controller.dart';
import 'package:todo_app/ui/state_holders/user%20details/user_details_controller.dart';
import 'package:todo_app/ui/widgets/package%20widget/spinkit%20package/spinkit_loader.dart';
import 'package:todo_app/ui/widgets/snack%20bar/snack_bar.dart';

class AddNewTodoScreen extends StatefulWidget {
  const AddNewTodoScreen({
    super.key,
    required this.user,
  });

  final UserModel? user;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add New Todo',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _titleTEController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
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
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        autovalidateMode: AutovalidateMode.disabled,
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
            GetBuilder<AddNewTodoController>(builder: (addNewTodoController) {
              return Visibility(
                visible: !addNewTodoController.inProgress,
                replacement: const Loader(),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   Todo todo = Todo(
                        //     _titleTEController.text.trim(),
                        //     _descriptionTEController.text.trim(),
                        //     DateTime.now(),
                        //   );
                        //   widget.onAddTodo(todo);
                        //   Navigator.pop(context);
                        // }
                        _onTapAddButton();
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
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapAddButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final bool result = await Get.find<AddNewTodoController>().addNewTodo(
        widget.user?.id ?? '',
        _titleTEController.text.trim(),
        _descriptionTEController.text);

    if (result) {
      Get.back(result: 'added');
      successSnackBar('New Todo', 'New todo added successfully');
    } else {
      failureSnackbar('New Todo', 'Add new todo failed!! Please try again');
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
