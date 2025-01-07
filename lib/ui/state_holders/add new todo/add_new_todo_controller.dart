import 'dart:developer';
import 'package:get/get.dart';
import 'package:todo_app/ui/utils/const.dart';

class AddNewTodoController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> addNewTodo(String id, String title, String description) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    try {
      final response = await supabase.from('user_notes').insert({
        'user_id': id,
        'title': title,
        'description': description,
      });
      isSuccess = true;
      log('Inserted successfully');
    } catch (error) {
      log('Error during insert: $error');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
