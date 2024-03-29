// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_exceptions.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/my_trash/firestore_functions/add_initial_user_to_users.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/utils/dialogs/error_dialog.dart';
import 'package:uniconnect/utils/dialogs/loading_dialog.dart';
import 'package:uniconnect/widgets/password_widget.dart';

// import 'dart:developer' as devtols show log;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool _isEmailValid = false;
  bool _passwordsMatch = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _emailController.addListener(_validateEmail);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      _isEmailValid = isValidEmail(_emailController.text);
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordsMatch =
          _passwordController.text.trim() ==
              _confirmPasswordController.text.trim() &&
              _passwordController.text.isNotEmpty &&
              _confirmPasswordController.text.isNotEmpty;
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
              const Text(
                'Almost there!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: BrandFonts.h1,
                 
                ),
              ),
              verticalSpace(20.0),
              const Text(
                'Enter your personal email and password to register your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: BrandFonts.regularText,
                  
                ),
              ),
              verticalSpace(20.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, why2EmailsRoute);
                },
                child: Text(
                  'wondering why 2 emails?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: BrandColor.infoLinks,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              verticalSpace(20.0),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress, // Show email keyboard
                decoration: const InputDecoration(
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
              ),
              verticalSpace(20.0),
              PasswordTextField(
                controller: _passwordController,
                hintText: 'password',
                labelText: 'Password',
                isConfirmPassword: false,
                onChanged: (_) => _validatePassword(),
              ),
              verticalSpace(20.0),
              PasswordTextField(
                controller: _confirmPasswordController,
                hintText: 'confirm password',
                labelText: 'Confirm Password',
                isConfirmPassword: true,
                onChanged: (_) => _validatePassword(),
              ),

              if (!_passwordsMatch)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Passwords do not match',
                    style: TextStyle(color: BrandColor.error),
                  ),
                ),
              verticalSpace(25.0),
              ElevatedButton(
                onPressed: _isEmailValid && _passwordsMatch
                    ? () async {
                        try {
                          final enteredEmail = _emailController.text.trim();
                          final enteredPassword = _passwordController.text;

                          await AuthService.currentAuthService().createUser(
                            email: enteredEmail,
                            password: enteredPassword,
                          );

                          final currentUser =
                              AuthService.currentAuthService().currentUser;
                          final userId = currentUser?.uid;

                          // Store initial user data in Firestore after successful signup
                          if (userId != null) {
                            showLoadingDialog(
                                context: context,
                                text: 'creating your account...');
                            await addUser(userID: userId, email: enteredEmail);
                          }

                          Navigator.popAndPushNamed(
                              context, moreInfoSignUpRoute);
                        } on WeakPasswordAuthException {
                          await showErrorDialog(
                              context, 'Password is too weak.');
                        } on EmailAlreadyInUseAuthException {
                          await showErrorDialog(
                              context, 'Email already in use.');
                        } on GenericAuthException {
                          await showErrorDialog(context, 'An error occurred.');
                        } on InvalidEmailAuthException {
                          await showErrorDialog(
                              context, 'Email is badly formatted.');
                        } catch (e) {
                          showErrorDialog(context,
                              'An Error Occurred. Please try again.  ');
                        }
                      }
                    : null, // Disable button if email is not valid or passwords don't match
                child: const Text('Submit',
                    style: TextStyle(fontSize: BrandFonts.textButtonSize)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
