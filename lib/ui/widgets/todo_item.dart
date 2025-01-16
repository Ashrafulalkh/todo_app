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
    required this.onUpdateTodo,
    required this.onTodoItemStatusChange,
  });

  final TaskModel todo;
  final VoidCallback onTodoItemStatusChange;
  final ValueChanged<TaskModel> onUpdateTodo;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 700;
    final isMidScreen = screenWidth > 600 && screenWidth <= 700;

    return InkWell(
      onTap: () async {
        final updatedTodo = await Get.to(
              () => TodoDetailsScreen(todo: todo, onUpdateTodo: onUpdateTodo),
        );
        if (updatedTodo != null) {
          onUpdateTodo(updatedTodo);
        }
      },
      child: SizedBox(
        width: screenWidth * 0.95,  // 90% of screen width to control the card width
        height: isLargeScreen || isMidScreen ? 700 : 400,  // Height adjusts based on screen size
        child: Card(
          elevation: 5,  // Increased elevation for a bigger shadow effect
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6), // Increased margin
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), // Increased border radius
          color: _getCardBGColor(),
          shadowColor: Colors.grey.withOpacity(0.4),  // Enhanced shadow for emphasis
          child: Padding(
            padding: EdgeInsets.all(isLargeScreen ? 16 : 12),  // Increased padding for more space
            child: isLargeScreen || isMidScreen
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTitle(screenWidth),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusIcon(),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildDescription(screenWidth),
                ),
                // Use Align with bottom for Date to avoid overflow
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildDate(screenWidth),
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTitle(screenWidth),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusIcon(),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildDescription(screenWidth),
                ),
                // Use Align with bottom for Date to avoid overflow
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildDate(screenWidth),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Using Flexible instead of Expanded (to avoid layout issues)
  Widget _buildTitle(double screenWidth) {
    return Text(
      todo.title,
      style: TextStyle(
        fontSize: screenWidth > 600 ? 20 : 15,
        fontWeight: FontWeight.bold,
        decoration: _getTextDecoration(),
        color: Colors.black87,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription(double screenWidth) {
    return Text(
      todo.description,
      style: TextStyle(
        fontSize: screenWidth > 600 ? 16 : 13,
        height: 1.3,
        color: Colors.black54,
        decoration: _getTextDecoration(),
      ),
      maxLines: screenWidth > 700 ? 10 : 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStatusIcon() {
    return GestureDetector(
      onTap: _updateTodoItemStatus,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: todo.isCompleted ? Colors.green.shade200 : Colors.red.shade200,
        child: Icon(
          _getIcon(),
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildDate(double screenWidth) {
    return Text(
      DateFormat.yMMMMEEEEd().add_jm().format(todo.createdAt!),
      style: TextStyle(
        fontSize: screenWidth > 600 ? 14 : 12,
        color: Colors.grey.shade600,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }

  Widget _buildStatusAndDate(double screenWidth, bool isLargeScreen) {
    return Column(
      children: [
        _buildStatusIcon(),
        const SizedBox(height: 12),
        _buildDate(screenWidth),
      ],
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
    if (result) {
      onTodoItemStatusChange();
    }
  }
}
