import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/screens/auth/sign_up_screen.dart';
import 'package:todo_app/ui/screens/todo_list/todo_list_screen.dart';
import 'package:todo_app/ui/state_holders/auth/sign_in_controller.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/assets_path.dart';
import 'package:todo_app/ui/widgets/package%20widget/spinkit%20package/spinkit_loader.dart';
import 'package:todo_app/ui/widgets/package%20widget/svg%20package/svg_picture.dart';
import 'package:todo_app/ui/widgets/snack%20bar/snack_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                const SvgPictureWidget(
                  assetPath: AssetsPath.signInImage,
                  height: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter a email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter a password';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter your password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<SignInController>(
                  builder: (signInController) {
                    return Visibility(
                      visible: !signInController.inProgress,
                      replacement: const Loader(),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapLogInButton();
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                        style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapLogInButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final bool result = await Get.find<SignInController>()
        .signIn(_emailTEController.text.trim(), _passwordController.text);

    if (result) {
      Get.offAll(() => const TodoListScreen());
    } else {
      failureSnackbar('Sign In', 'Signed In failed!! Please try again');
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
