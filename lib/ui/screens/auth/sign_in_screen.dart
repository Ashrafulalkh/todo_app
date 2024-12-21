import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/screens/auth/sign_up_screen.dart';
import 'package:todo_app/ui/screens/todo_list/todo_list_screen.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/assets_path.dart';
import 'package:todo_app/ui/widgets/package%20widget/svg%20package/svg_picture.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          children: [
            const SizedBox(
              height: 38,
            ),
            const SvgPictureWidget(
              assetPath: AssetsPath.signInImage,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => const TodoListScreen());
              },
              child: const Text('Log In'),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                const SizedBox(
                  width: 6,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: AppColors.themeColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
