import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/widgets/empty_list_widgets.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UndoneTodoList extends StatefulWidget {
  const UndoneTodoList({
    super.key,
    required this.todoList,
    required this.onDelete,
    required this.onStatusChange,
  });

  final List<TaskModel> todoList;
  final Function(int) onDelete;
  final Function() onStatusChange;

  @override
  UndoneTodoListState createState() => UndoneTodoListState();
}

class UndoneTodoListState extends State<UndoneTodoList> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Ensure minimum of 2 columns for small screens, increase for larger screens.
    int crossAxisCount = screenWidth > 800
        ? 7
        : screenWidth > 600
            ? 6
            : 2;

    // Adjust aspect ratio for balance between width and height.
    double childAspectRatio = screenWidth > 600 ? 0.65 : 1;

    if (widget.todoList.isEmpty) {
      return const EmptyListWidgets();
    }

    return Padding(
      padding: const EdgeInsets.all(2),
      child: GridView.builder(
        itemCount: widget.todoList.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                widget.onDelete(index);
                setState(() {});
              }),
              children: const [
                SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: TodoItem(
              todo: widget.todoList[index],
              onUpdateTodo: (TaskModel updatedTodo) {
                setState(() {
                  widget.todoList[index] =
                      updatedTodo; // Update the todo with new data
                });
              },
              onTodoItemStatusChange: () {
                widget.onStatusChange();
              },
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: childAspectRatio,
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
