import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              _passwordController.text.isNotEmpty;
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
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
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
                  Navigator.pushNamed(context, '/why-2-emails');
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
                    ? () {
                        // Handle button press
                        Navigator.popAndPushNamed(
                            context, '/more-info-sign-up');
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
