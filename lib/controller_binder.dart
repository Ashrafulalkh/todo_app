import 'package:get/get.dart';
import 'package:todo_app/ui/state_holders/add%20new%20todo/add_new_todo_controller.dart';
import 'package:todo_app/ui/state_holders/auth/auth_controller.dart';
import 'package:todo_app/ui/state_holders/auth/sign_in_controller.dart';
import 'package:todo_app/ui/state_holders/auth/sign_up_controller.dart';
import 'package:todo_app/ui/state_holders/todo%20list/all_todo_list_controller.dart';
import 'package:todo_app/ui/state_holders/todo%20list/update_todo_item_status_controller.dart';
import 'package:todo_app/ui/state_holders/user%20details/user_details_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(UserDetailsController());
    Get.put(AllTodoListController());
    Get.put(UpdateTodoItemStatusController());
    Get.put(AddNewTodoController());
    Get.put(SignInController());
    Get.put(SignUpController());
  }
}
