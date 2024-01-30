import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';

class StudentVerify extends StatefulWidget {
  const StudentVerify({Key? key}) : super(key: key);

  @override
  State<StudentVerify> createState() => _StudentVerifyState();
}

class _StudentVerifyState extends State<StudentVerify> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;

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

  bool isValidEmail(String email) {
    // You can use a regex or any other method to validate the email
    // For simplicity, I'm using a basic check here
    return email.isNotEmpty && email.contains('@');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset('assets/img/logo ss.png', height: 100, width: 200),
            verticalSpace(25),
            const Text(
              'Connect locally, expand globally with other students',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: BrandFonts.h1,
                fontFamily: BrandFonts.fontFamily,
              ),
            ),
            verticalSpace(20),
            const Text(
              'Enter your email to verify your student status',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: BrandFonts.regularText,
                fontFamily: BrandFonts.fontFamily,
              ),
            ),
            verticalSpace(20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'example@lsbu.ac.uk',
                border: OutlineInputBorder(),
                labelText: 'email',
              ),
            ),
            verticalSpace(20),
            ElevatedButton(
              onPressed: _isEmailValid
                  ? () {
                      // Handle button press
                      Navigator.pushReplacementNamed(
                          context, statusVerifiedRoute);
                    }
                  : null, // Disable the button if email is not valid
              child: const Text(
                'Verify',
                style: TextStyle(
                  fontSize: BrandFonts.textButtonSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
