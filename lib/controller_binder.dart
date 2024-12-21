import 'package:get/get.dart';
import 'package:todo_app/ui/state_holders/auth/auth_controller.dart';
import 'package:todo_app/ui/state_holders/auth/sign_in_controller.dart';
import 'package:todo_app/ui/state_holders/auth/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(SignInController());
    Get.put(SignUpController());
  }
}
