import 'dart:developer';

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

    try {
      // Get the current user's ID from Supabase
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) {
        throw Exception("No logged-in user found.");
      }

      // Query the `user_profiles` table for the logged-in user's details
      final response = await supabase
          .from('user_profiles')
          .select()
          .eq('id', currentUser.id) // Assuming the table has `user_id`
          .single();

      log(response.toString());
      log(currentUser.id);

      // Map the response to your UserModel
      _user = UserModel.fromJson(response);

      // Save the user data in the AuthController
      await AuthController().saveUserData(_user);
      isSuccess = true;
      update();
    } catch (e) {
      log("Error fetching user details: $e");
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
