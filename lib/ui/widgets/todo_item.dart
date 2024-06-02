import 'package:flutter/material.dart';
import 'package:todo_app/entities/todo.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key, required this.todo, required this.onIconButtonPressed,
  });

  final Todo todo;
  final VoidCallback onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey,
        surfaceTintColor: _getCardTintColor(todo.isDone),
        color: _getCardBGColor(todo.isDone),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                todo.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  decoration: _getTextDecoration(todo.isDone),
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.description,style: TextStyle(fontSize: 15,decoration: _getTextDecoration(todo.isDone)),),
                const SizedBox(
                  height: 10,
                ),
                Text(DateFormat.yMEd().add_jms().format(todo.dateTime)),
              ],
            ),
            trailing: _buildIconButton(todo.isDone),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(bool isDone) {
    return GestureDetector(
      onTap: onIconButtonPressed,
      child: CircleAvatar(
        child: Icon(_getIcon(!todo.isDone)),
      ),
    );
  }

  IconData _getIcon(bool isDone) {
    return isDone ? Icons.check : Icons.clear;
  }

  TextDecoration? _getTextDecoration(bool isDone) {
    return isDone ? TextDecoration.lineThrough : null;
  }
  
  Color? _getCardTintColor(bool isDone) {
    return isDone ? Colors.green : null;
  }

  Color? _getCardBGColor(bool isDone) {
    return isDone ? Colors.green.shade100 : null;
  }

}