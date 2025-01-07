import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/widgets/empty_list_widgets.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DoneTodoList extends StatefulWidget {
  const DoneTodoList({
    super.key,
    required this.todoList,
    required this.onDelete,
    required this.onStatusChange,
  });

  final List<TaskModel> todoList;
  final Function(int) onDelete;
  final Function() onStatusChange;

  @override
  DoneTodoListState createState() => DoneTodoListState();
}

class DoneTodoListState extends State<DoneTodoList> {
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
                widget.todoList[index] = updatedTodo;
              });
            },
            onTodoItemStatusChange: () {
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
