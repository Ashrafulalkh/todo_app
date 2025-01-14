import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/ui/utils/const.dart';

class SignOutController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> signOut() async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    try {
      await supabase.auth.signOut();
      isSuccess = true;
      // Handle navigation to login or other relevant screens
    } catch (e) {
      log('An error occurred during logout: $e');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
