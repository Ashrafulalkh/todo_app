import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/ui/state_holders/todo%20list/all_todo_list_controller.dart';
import 'package:todo_app/ui/utils/const.dart';

class UpdateTodoItemStatusController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;


  Future<bool> updateTodoItemStatus(int todoItemId, bool newValue) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    try {
      final response =
      await supabase.from('user_notes').update({'is_completed': newValue}).eq('id', todoItemId);
        isSuccess = true;
        log('Success');
        update();
    } catch (e) {
      log(e.toString());
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
