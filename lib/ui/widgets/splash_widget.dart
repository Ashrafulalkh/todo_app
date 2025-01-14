import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/screens/auth/sign_in_screen.dart';
import 'package:todo_app/ui/screens/todo_list/todo_list_screen.dart';
import 'package:todo_app/ui/state_holders/auth/auth_controller.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isLoggedIn = await Get.find<AuthController>().checkAuthState();
    if(isLoggedIn){
      Get.offAll(() => const TodoListScreen());
    }else {
      Get.offAll(() => const SignInScreen());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/splash_screen2.json',
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.scaleDown,
          ),
        ],
      ),
    );
  }
}
