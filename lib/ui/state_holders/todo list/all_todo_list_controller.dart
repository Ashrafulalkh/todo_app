import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/data/models/task/task_model.dart';
import 'package:todo_app/ui/utils/const.dart';

class AllTodoListController extends GetxController {
  bool _inProgress = false;
  List<TaskModel> _taskList = [];

  bool get inProgress => _inProgress;
  List<TaskModel> get taskList => _taskList;

  Future<bool> fetchAllTodoList(String userId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      final response = await supabase
          .from('user_notes')
          .select('*')
          .eq('user_id', userId); // Correct use of execute()

      log('Raw Response: $response');

      if ((response as List).isNotEmpty) {
        isSuccess = true;
        _taskList = (response as List)
            .map((todoList) => TaskModel.fromJson(todoList))
            .toList();
        update();
      }
    } catch (e) {
      log('Exception: $e');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
