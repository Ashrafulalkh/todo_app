import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/ui/screens/todo_list/todo_details_screen.dart';
import 'package:todo_app/ui/state_holders/todo%20list/update_todo_item_status_controller.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onUpdateTodo, required this.onTodoItemStatusChange,
  });

  final TaskModel todo;

  final VoidCallback onTodoItemStatusChange;
  final ValueChanged<TaskModel> onUpdateTodo;

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
        color: _getCardBGColor(),
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
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        decoration: _getTextDecoration(),
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _updateTodoItemStatus,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: todo.isCompleted
                          ? Colors.green.shade200
                          : Colors.red.shade200,
                      child: Icon(
                        _getIcon(),
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
                  fontSize: 15,
                  height: 1.3,
                  color: Colors.black54,
                  decoration: _getTextDecoration(),
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4,),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat.yMMMMEEEEd().add_jm().format(todo.createdAt!),
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon() {
    return todo.isCompleted ? Icons.close : Icons.check;
  }

  TextDecoration? _getTextDecoration() {
    return todo.isCompleted ? TextDecoration.lineThrough : null;
  }

  Color _getCardBGColor() {
    return todo.isCompleted ? Colors.green.shade50 : Colors.white;
  }

  Future<void> _updateTodoItemStatus() async {
    final result = await Get.find<UpdateTodoItemStatusController>()
        .updateTodoItemStatus(todo.id, !todo.isCompleted);
    if(result){
      onTodoItemStatusChange();
    }
  }
}
