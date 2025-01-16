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

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    final content = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SvgPictureWidget(
                assetPath: AssetsPath.signInImage,
                height: 300,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailTEController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter an email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: !_showPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GetBuilder<SignInController>(
                builder: (signInController) {
                  return Visibility(
                    visible: !signInController.inProgress,
                    replacement: const Loader(),
                    child: ElevatedButton(
                      onPressed: _onTapLogInButton,
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Handle forgot password functionality
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLargeScreen
          ? Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: content,
        ),
      )
          : content,
    );
  }

  Future<void> _onTapLogInButton() async {
    if (!_formKey.currentState!.validate()) return;

    final bool result = await Get.find<SignInController>()
        .signIn(_emailTEController.text.trim(), _passwordController.text);

    if (result) {
      Get.offAll(() => const TodoListScreen());
    } else {
      failureSnackbar('Sign In', 'Sign In failed! Please try again.');
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
