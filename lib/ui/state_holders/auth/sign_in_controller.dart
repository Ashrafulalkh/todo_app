import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/ui/state_holders/auth/auth_controller.dart';
import 'package:todo_app/ui/utils/const.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final response = await supabase.auth
        .signInWithPassword(password: password, email: email);

    if (response.session != null) {
      isSuccess = true;
      Get.find<AuthController>().saveAccessToken(response.session!.accessToken);
      log('Successful');
      update();
    } else {
      log('Insert data failed!!');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
