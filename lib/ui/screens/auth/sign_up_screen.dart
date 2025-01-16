import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/screens/auth/sign_in_screen.dart';
import 'package:todo_app/ui/state_holders/auth/sign_up_controller.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/assets_path.dart';
import 'package:todo_app/ui/widgets/package%20widget/spinkit%20package/spinkit_loader.dart';
import 'package:todo_app/ui/widgets/package%20widget/svg%20package/svg_picture.dart';
import 'package:todo_app/ui/widgets/snack%20bar/snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    final content = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 35),
              const SvgPictureWidget(
                assetPath: AssetsPath.signUpImage,
                height: 290,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _firstNameTEController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your first name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your first name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameTEController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your last name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your last name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailTEController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordTEController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 16),
              GetBuilder<SignUpController>(
                builder: (signUpController) {
                  return Visibility(
                    visible: !signUpController.inProgress,
                    replacement: const Loader(),
                    child: ElevatedButton(
                      onPressed: _onTapRegisterButton,
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const SignInScreen());
                    },
                    child: const Text(
                      'Sign In',
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

  Future<void> _onTapRegisterButton() async {
    if (!_formKey.currentState!.validate()) return;

    final bool result = await Get.find<SignUpController>().signUp(
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );

    if (result) {
      Get.offAll(() => const SignInScreen());
      successSnackBar('Sign Up', 'You have been successfully registered');
    } else {
      failureSnackbar('Sign Up', 'Registration failed!! Please try again');
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
