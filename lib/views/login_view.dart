import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isEmailValid = false;
  bool _passwordsMatch = true;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_validateEmail);
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
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
                onChanged: (_) => _validatePassword(),
                decoration: const InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
              verticalSpace(20.0),
              verticalSpace(25.0),
              ElevatedButton(
                onPressed: _isEmailValid && _passwordsMatch
                    ? () {
                        // Navigator.popAndPushNamed(context, moreInfoSignUpRoute);
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
