import 'package:get/get.dart';
import 'package:todo_app/ui/state_holders/auth/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }
}
