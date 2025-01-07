import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/models/user/user_model.dart';
import 'package:todo_app/ui/state_holders/auth/auth_controller.dart';
import 'package:todo_app/ui/utils/const.dart';

class UserDetailsController extends GetxController {
  bool _inProgress = false;
  UserModel? _user;

  bool get inProgress => _inProgress;
  UserModel? get user => _user;

  Future<bool> fetchUserDetails() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try{
      final response = await supabase.from('user_profiles').select().limit(1).single();
      debugPrint(response.toString());
      _user = UserModel.fromJson(response);
      await AuthController().saveUserData(_user);
    }catch(e) {
      debugPrint(e.toString());
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}