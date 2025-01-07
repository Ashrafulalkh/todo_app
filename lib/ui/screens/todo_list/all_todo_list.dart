import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/state_holders/todo%20list/all_todo_list_controller.dart';
import 'package:todo_app/ui/state_holders/todo%20list/update_todo_item_status_controller.dart';
import 'package:todo_app/ui/widgets/empty_list_widgets.dart';
import 'package:todo_app/ui/widgets/package%20widget/spinkit%20package/spinkit_loader.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllTodoListTab extends StatefulWidget {
  const AllTodoListTab({
    super.key,
    required this.todoList,
    required this.onDelete,
    required this.onStatusChange,
  });

  final List<TaskModel> todoList;
  final Function(int) onDelete;
  final Function() onStatusChange;

  @override
  AllTodoListTabState createState() => AllTodoListTabState();
}

class AllTodoListTabState extends State<AllTodoListTab> {
  @override
  Widget build(BuildContext context) {
    if (widget.todoList.isEmpty) {
      return const EmptyListWidgets();
    }
    return GridView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () {
                widget.onDelete(index);
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
    );
  }
}

void doNothing(BuildContext context) {}
