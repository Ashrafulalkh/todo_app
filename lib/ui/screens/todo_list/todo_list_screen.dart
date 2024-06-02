import 'package:flutter/material.dart';
import 'package:todo_app/entities/todo.dart';
import 'package:todo_app/ui/screens/add_new_todo_screen.dart';
import 'package:todo_app/ui/screens/todo_list/all_todo_list.dart';
import 'package:todo_app/ui/screens/todo_list/done_todo_list.dart';
import 'package:todo_app/ui/screens/todo_list/undone_todo_list.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

final List<Todo> _todoList = [];

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          bottom: _buildTabBar(),
        ),
        body: TabBarView(
          children: [
            AllTodoListTab(
              onDelete:_deleteTodo,
              onStatusChange: _toggleTodoStatus,
              todoList: _todoList,
            ),
            UndoneTodoList(
              onDelete:_deleteTodo,
              onStatusChange: _toggleTodoStatus,
              todoList: _todoList.where((item) => item.isDone == false).toList(),
            ),
            DoneTodoList(
              onDelete:_deleteTodo,
              onStatusChange: _toggleTodoStatus,
              todoList: _todoList.where((item) => item.isDone == true).toList(),
            ),
          ],
        ),
        floatingActionButton: _buildAddTodoListButton(context),
      ),
    );
  }

  Widget _buildAddTodoListButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddNewTodoScreen(onAddTodo: _addNewTodo),
          ),
        );
      },
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      tooltip: 'Add New Todo',
      label: const Text('Add New Todo'),
      icon: const Icon(Icons.add),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    );
  }

  TabBar _buildTabBar() {
    return const TabBar(
      labelColor: Colors.white,
      tabs: [
        Tab(
          text: 'All',
        ),
        Tab(
          text: 'Undone',
        ),
        Tab(
          text: 'Done',
        ),
      ],
    );
  }

  void _addNewTodo(Todo todo) {
    _todoList.add(todo);
    if (mounted) {
      setState(() {});
    }
  }

  void _deleteTodo(int index) {
    _todoList.removeAt(index);
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleTodoStatus(int index) {
    _todoList[index].isDone = !_todoList[index].isDone;
    if (mounted) {
      setState(() {});
    }
  }
}
