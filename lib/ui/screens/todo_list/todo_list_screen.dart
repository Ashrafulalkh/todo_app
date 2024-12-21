import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/ui/screens/add_new_todo_screen.dart';
import 'package:todo_app/ui/screens/todo_list/all_todo_list.dart';
import 'package:todo_app/ui/screens/todo_list/done_todo_list.dart';
import 'package:todo_app/ui/screens/todo_list/undone_todo_list.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Todo List',
            style: TextStyle(color: Colors.black),
          ),
          bottom: _buildTabBar(),
        ),
        body: _buildTabBarView(),
        floatingActionButton: _buildAddTodoButton(),
      ),
    );
  }

  /// Build FloatingActionButton
  Widget _buildAddTodoButton() {
    return FloatingActionButton.extended(
      onPressed: () => _navigateToAddNewTodoScreen(),
      foregroundColor: Colors.black,
      backgroundColor: AppColors.themeColor,
      label: const Text('Add New Todo'),
      icon: const Icon(Icons.add),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    );
  }

  /// Build TabBar
  TabBar _buildTabBar() {
    return const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      indicatorColor: Colors.white,
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'Undone'),
        Tab(text: 'Done'),
      ],
    );
  }

  /// Build TabBarView with respective Todo lists
  Widget _buildTabBarView() {
    return TabBarView(
      children: [
        AllTodoListTab(
          todoList: _todoList,
          onDelete: _deleteTodo,
          onStatusChange: _toggleTodoStatus,
        ),
        UndoneTodoList(
          todoList: _todoList.where((todo) => !todo.isDone).toList(),
          onDelete: _deleteTodo,
          onStatusChange: _toggleTodoStatus,
        ),
        DoneTodoList(
          todoList: _todoList.where((todo) => todo.isDone).toList(),
          onDelete: _deleteTodo,
          onStatusChange: _toggleTodoStatus,
        ),
      ],
    );
  }

  /// Add a new Todo and refresh UI
  void _addNewTodo(Todo todo) {
    setState(() {
      _todoList.add(todo);
    });
  }

  /// Delete a Todo by index
  void _deleteTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  /// Toggle a Todo's done status
  void _toggleTodoStatus(int index) {
    setState(() {
      _todoList[index].isDone = !_todoList[index].isDone;
    });
  }

  /// Navigate to the AddNewTodoScreen
  void _navigateToAddNewTodoScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTodoScreen(onAddTodo: _addNewTodo),
      ),
    );
  }
}
