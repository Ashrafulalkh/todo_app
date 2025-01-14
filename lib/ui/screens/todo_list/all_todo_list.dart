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
    required this.onStatusChange, required this.user,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.todoList.isEmpty) {
      log('todoList length in AllTodoListTab: ${widget.todoList.length}');
      setState(() {});
      log('Rendering empty list widget');
      return const EmptyListWidgets();
    }
    return RefreshIndicator(
      onRefresh: () {
        return Get.find<AllTodoListController>().fetchAllTodoList(widget.user?.id ?? '');
      },
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
                // You can manage the list update logic here
                setState(() {
                  widget.todoList[index] = updatedTodo;
                });
              }, onTodoItemStatusChange: () {
                widget.onStatusChange();
            },
            ),
          );
        },
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
