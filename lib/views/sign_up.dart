
import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_exceptions.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/firestore_functions/add_initial_user_to_users.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';
import 'dart:developer' as devtols show log;

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
          _passwordController.text == _confirmPasswordController.text &&
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
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
              verticalSpace(20.0),
              const Text(
                'Enter your personal email and password to register your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: BrandFonts.regularText,
                  fontFamily: BrandFonts.fontFamily,
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
              TextField(
                controller: _passwordController,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                onChanged: (_) => _validatePassword(),
                decoration: const InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
              verticalSpace(20.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                onChanged: (_) => _validatePassword(),
                decoration: const InputDecoration(
                  hintText: 'confirm password',
                  border: OutlineInputBorder(),
                  labelText: 'confirm password',
                ),
              ),
              if (!_passwordsMatch)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Passwords do not match',
                    style: TextStyle(color: BrandColor.error),
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
              verticalSpace(25.0),
              ElevatedButton(
                onPressed: _isEmailValid && _passwordsMatch
                    ? () async {
                        try {
                          final enteredEmail = _emailController.text;
                          final enteredPassword = _passwordController.text;

                         
                          await AuthService.firebase().createUser(
                            email: enteredEmail,
                            password: enteredPassword,
                          );
                          
                          final currentUser =
                              AuthService.firebase().currentUser;
                          final userId = currentUser?.id;

                          // Store initial user data in Firestore after successful signup
                          if (userId != null) {
                            await addUser(userID: userId, email: enteredEmail);
                          }
                          
                          // ignore: use_build_context_synchronously
                          Navigator.popAndPushNamed(
                              context, moreInfoSignUpRoute);
                        } on UserNotFoundAuthException {
                          devtols.log('No user found for that email.');
                        } on WrongPasswordAuthException {
                          devtols.log('Wrong password provided for that user.');
                        } on EmailAlreadyInUseAuthException {
                          devtols.log('Email is already in use.');
                        } on WeakPasswordAuthException {
                          devtols.log('Password is too weak.');
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
