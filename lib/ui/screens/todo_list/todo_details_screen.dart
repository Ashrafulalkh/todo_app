import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/screens/todo_list/edit_todo_screen.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({
    super.key,
    required this.todo,
    required this.onUpdateTodo,
  });

  final TaskModel todo;
  final ValueChanged<TaskModel> onUpdateTodo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Todo Details",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () async {
              // Navigate to EditTodoScreen and wait for the updated Todo
              final updatedTodo = await Get.to(
                    () => EditTodoScreen(todo: todo),
              );
              if (updatedTodo != null) {
                onUpdateTodo(updatedTodo);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              DateFormat.yMMMMEEEEd().add_jm().format(todo.createdAt!),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const Divider(
              thickness: 1,
              height: 32,
            ),
            Text(
              todo.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            if (todo.isCompleted)
              const Align(
                alignment: Alignment.centerRight,
                child: Chip(
                  label: Text(
                    "Completed",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: AppColors.themeColor,
                ),
              )
            else
              const Align(
                alignment: Alignment.centerRight,
                child: Chip(
                  label: Text(
                    "Pending",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.orange,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

