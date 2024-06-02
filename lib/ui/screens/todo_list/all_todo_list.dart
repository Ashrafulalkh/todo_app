import 'package:flutter/material.dart';
import 'package:todo_app/entities/todo.dart';
import 'package:todo_app/ui/widgets/empty_list_widgets.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllTodoListTab extends StatelessWidget {
  const AllTodoListTab(
      {super.key,
      required this.onDelete,
      required this.onStatusChange,
      required this.todoList});

  final List<Todo> todoList;
  final Function(int) onDelete;
  final Function(int) onStatusChange;

  @override
  Widget build(BuildContext context) {
    if(todoList.isEmpty) {
      return const EmptyListWidgets();
    }
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: UniqueKey(),
          // The start action pane is the one at the left or the top side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              onDelete(index);
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
            todo: todoList[index],
            onIconButtonPressed: () {
              onStatusChange(index);
            },
          ),
        );
      },
    );
  }
}

void doNothing(BuildContext context) {}
