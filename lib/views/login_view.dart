// ignore_for_file: empty_catches, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_exceptions.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/dialogs/error_dialog.dart';
import 'package:uniconnect/utils/dialogs/loading_dialog.dart';
import 'package:uniconnect/utils/spaces.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isEmailValid = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController.addListener(_validateEmail);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      _isEmailValid = isValidEmail(_emailController.text);
    });
  }

  // Function to validate an email address
  bool isValidEmail(String email) {
    return email.contains('@') && email.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Image.asset('assets/img/logo ss.png', height: 100, width: 200),
              verticalSpace(20.0),
              const Text(
                'Enter your personal email and password to sign into your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: BrandFonts.regularText,
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
              verticalSpace(20.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
              ),
              verticalSpace(20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
              verticalSpace(20.0),
              verticalSpace(25.0),
              ElevatedButton(
                onPressed: _isEmailValid
                    ? () async {
                        final enteredEmail = _emailController.text;
                        final enteredPassword = _passwordController.text;

                        try {
                          await AuthService.firebase().login(
                            email: enteredEmail,
                            password: enteredPassword,
                          );

                          showLoadingDialog(
                              context: context, text: 'Logging in...');
                          Navigator.popAndPushNamed(
                              context, finishCarouselRoute);
                        } on UserNotFoundAuthException {
                          await showErrorDialog(
                              context, 'No user found for that credentials.');
                        } on WrongPasswordAuthException {
                          await showErrorDialog(
                              context, 'Wrong credentials provided.');
                        } on InvalidEmailAuthException {
                          await showErrorDialog(context,
                              'Wrong credentials provided for that user.');
                        } on GenericAuthException {
                          await showErrorDialog(
                              context, 'Wrong credentials provided.');
                        }
                      }
                    : null, // Disable button if email is not valid or passwords don't match
                child: const Text('Login',
                    style: TextStyle(fontSize: BrandFonts.textButtonSize)),
              ),
              verticalSpace(20.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, studentVerifyRoute);
                },
                child: Text(
                  'Have no account? create one',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: BrandColor.infoLinks,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
