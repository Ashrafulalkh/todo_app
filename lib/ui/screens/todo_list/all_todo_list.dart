import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/widgets/empty_list_widgets.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllTodoListTab extends StatefulWidget {
  const AllTodoListTab({
    super.key,
    required this.todoList,
    required this.onDelete,
    required this.onStatusChange,
  });

  final List<Todo> todoList;
  final Function(int) onDelete;
  final Function(int) onStatusChange;

  @override
  AllTodoListTabState createState() => AllTodoListTabState();
}

class AllTodoListTabState extends State<AllTodoListTab> {
  // When status changes or todo is deleted, the todoList needs to be updated
  void updateTodoList(int index) {
    setState(() {
      // When the status is changed
      widget.onStatusChange(index);
    });
  }

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
            onIconButtonPressed: () {
              updateTodoList(index);
            },
            onUpdateTodo: (Todo updatedTodo) {
              // You can manage the list update logic here
              setState(() {
                widget.todoList[index] = updatedTodo;
              });
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
