import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'dart:developer' as devtols show log;
import 'package:uniconnect/utils/spaces.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Almost there!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: BrandFonts.h1,
                    fontFamily: BrandFonts.fontFamily),
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
              const TextField(
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
              ),
              verticalSpace(20.0),
              const TextField(
                obscureText: true, // Use secure text for passwords.
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
              verticalSpace(20.0),
              const TextField(
                obscureText: true, // Use secure text for passwords.
                decoration: InputDecoration(
                  hintText: 'confim password',
                  border: OutlineInputBorder(),
                  labelText: 'confrim password',
                ),
              ),
              verticalSpace(20.0),
              InkWell(
                onTap: () {
                  devtols.log('Button pressed');
                  // todo; navigate to why 2 emails page
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
                onPressed: () {
                  // Handle button press
                },
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
