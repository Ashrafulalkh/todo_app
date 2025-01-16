import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/data/models/user/user_model.dart';
import 'package:todo_app/ui/state_holders/todo%20list/all_todo_list_controller.dart';
import 'package:todo_app/ui/widgets/empty_list_widgets.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllTodoListTab extends StatefulWidget {
  const AllTodoListTab({
    super.key,
    required this.todoList,
    required this.onDelete,
    required this.onStatusChange,
    required this.user,
  });

  final List<TaskModel> todoList;
  final Function(int) onDelete;
  final Function() onStatusChange;
  final UserModel? user;

  @override
  AllTodoListTabState createState() => AllTodoListTabState();
}

class AllTodoListTabState extends State<AllTodoListTab> {
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
      log('todoList length in AllTodoListTab: ${widget.todoList.length}');
      setState(() {});
      log('Rendering empty list widget');
      return const EmptyListWidgets();
    }

    return RefreshIndicator(
      onRefresh: () {
        return Get.find<AllTodoListController>()
            .fetchAllTodoList(widget.user?.id ?? '');
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: GridView.builder(
          itemCount: widget.todoList.length,
          itemBuilder: (context, index) {
            final todoItems = widget.todoList[index];
            return Slidable(
              key: UniqueKey(),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {
                    widget.onDelete(todoItems.id);
                    setState(() {});
                  },
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      widget.onDelete(todoItems.id);
                      setState(() {});
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: TodoItem(
                todo: widget.todoList[index],
                onUpdateTodo: (TaskModel updatedTodo) {
                  // Update the specific todo item.
                  setState(() {
                    widget.todoList[index] = updatedTodo;
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
      ),
    );
  }
}
