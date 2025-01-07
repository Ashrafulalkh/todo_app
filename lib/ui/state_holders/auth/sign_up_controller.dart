import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/ui/utils/const.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> signUp(
      String firstName, String lastName, String email, String password) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final response =
        await supabase.auth.signUp(password: password, email: email);

    final id = response.user?.id;

    if (id != null) {
      isSuccess = true;
      await supabase.from('user_profiles').insert(
        {
          'id': id,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'created_at': DateTime.now().toIso8601String(),
        },
      );
      log('Successful');
    } else {
      log('Insert data failed!!');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
