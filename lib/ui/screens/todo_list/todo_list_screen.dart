import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/models/user/user_model.dart';
import 'package:todo_app/ui/screens/add_new_todo_screen.dart';
import 'package:todo_app/ui/screens/todo_list/all_todo_list.dart';
import 'package:todo_app/ui/screens/todo_list/done_todo_list.dart';
import 'package:todo_app/ui/screens/todo_list/undone_todo_list.dart';
import 'package:todo_app/ui/state_holders/todo%20list/all_todo_list_controller.dart';
import 'package:todo_app/ui/state_holders/todo%20list/update_todo_item_status_controller.dart';
import 'package:todo_app/ui/state_holders/user%20details/user_details_controller.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/widgets/package%20widget/spinkit%20package/spinkit_loader.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todoList = [];
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Separate asynchronous method to handle initialization
  Future<void> _initializeData() async {
    // Fetch user details and wait for them to load
    await Get.find<UserDetailsController>().fetchUserDetails();

    // Load user data
    _fetchUserData();

    // Ensure `user` is loaded before calling the next method
    if (user != null) {
      await Get.find<AllTodoListController>().fetchAllTodoList(user!.id);
    } else {
      log("User data not found.");
    }

    setState(() {});

    Get.find<AllTodoListController>().update();

  }

  void _fetchUserData() {
    user = Get.find<UserDetailsController>()
        .user; // Replace with your actual logic
  }

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
        body:
            GetBuilder<UserDetailsController>(builder: (userDetailsController) {
          return Visibility(
              visible: !userDetailsController.inProgress,
              replacement: const Loader(),
              child: GetBuilder<AllTodoListController>(
                  builder: (allTodoListController) {
                return Visibility(
                    visible: !allTodoListController.inProgress,
                    replacement: const Loader(),
                    child: _buildTabBarView());
              }));
        }),
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
        GetBuilder<AllTodoListController>(builder: (allTodoListController) {
          return AllTodoListTab(
            todoList: allTodoListController.taskList,
            onDelete: _deleteTodo,
            onStatusChange: _toggleTodoStatus,
          );
        }),
        GetBuilder<AllTodoListController>(builder: (allTodoListController) {
          return UndoneTodoList(
            todoList: allTodoListController.taskList
                .where((task) => !task.isCompleted)
                .toList(),
            onDelete: _deleteTodo,
            onStatusChange: _toggleTodoStatus,
          );
        }),
        GetBuilder<AllTodoListController>(builder: (allTodoListController) {
          return DoneTodoList(
            todoList: allTodoListController.taskList
                .where((task) => task.isCompleted)
                .toList(),
            onDelete: _deleteTodo,
            onStatusChange: _toggleTodoStatus,
          );
        }),
      ],
    );
  }

  /// Delete a Todo by index
  void _deleteTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  /// Toggle a Todo's done status
  void _toggleTodoStatus() async {
    Get.find<AllTodoListController>().fetchAllTodoList(user?.id ?? '');
  }

  Future<void> _navigateToAddNewTodoScreen() async {
    Get.to(
      () => GetBuilder<UserDetailsController>(
        builder: (userDetailsController) {
          return AddNewTodoScreen(
            user: userDetailsController.user,
          );
        },
      ),
    )?.then(
      (result) async {
        // Check the result and perform actions
        if (result == 'added') {
          // Example: Refresh the list or show a success message
          await Get.find<AllTodoListController>()
              .fetchAllTodoList(user?.id ?? '');
        } else {
          log("No new Todo was added or operation was canceled.");
        }
      },
    );
  }
}
