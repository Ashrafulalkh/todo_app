import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/screens/todo_list/todo_details_screen.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onIconButtonPressed,
    required this.onUpdateTodo,
  });

  final Todo todo;
  final VoidCallback onIconButtonPressed;
  final ValueChanged<Todo> onUpdateTodo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final updatedTodo = await Get.to(
          () => TodoDetailsScreen(todo: todo, onUpdateTodo: onUpdateTodo),
        );
        if (updatedTodo != null) {
          onUpdateTodo(updatedTodo);
        }
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: _getCardBGColor(todo.isDone),
        shadowColor: Colors.grey.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: _getTextDecoration(todo.isDone),
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onIconButtonPressed,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: todo.isDone
                          ? Colors.green.shade200
                          : Colors.red.shade200,
                      child: Icon(
                        _getIcon(todo.isDone),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                todo.description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black54,
                  decoration: _getTextDecoration(todo.isDone),
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat.yMMMMEEEEd().add_jm().format(todo.dateTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(bool isDone) {
    return isDone ? Icons.check : Icons.pending;
  }

  TextDecoration? _getTextDecoration(bool isDone) {
    return isDone ? TextDecoration.lineThrough : null;
  }

  Color _getCardBGColor(bool isDone) {
    return isDone ? Colors.green.shade50 : Colors.white;
  }
}
