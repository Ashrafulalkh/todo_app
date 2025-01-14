import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/ui/utils/const.dart';

class DeleteTodoItemController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> deleteTodoItem(int todoItemId) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    try {
      await supabase.from('user_notes').delete().eq('id', todoItemId);

      log('$todoItemId');
      log('Success');
      isSuccess = true;
      update();
    } catch (e) {
      log(e.toString());
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
