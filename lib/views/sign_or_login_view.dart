import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';


class LoginOrSignUpView extends StatefulWidget {
  const LoginOrSignUpView({super.key});

  @override
  State<LoginOrSignUpView> createState() => _LoginOrSignUpViewState();
}

class _LoginOrSignUpViewState extends State<LoginOrSignUpView> {
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: 1,
                child: Image.asset('assets/img/logo ss.png',
                    height: 100, width: 250),
              ),
              verticalSpace(20),
              const Text(
                'A world of students',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: BrandFonts.h1,
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
              verticalSpace(20),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  Navigator.pushNamed(context, loginRoute);
                },
                child: const Text('Login',
                    style: TextStyle(
                      fontFamily: BrandFonts.fontFamily,
                      fontSize: BrandFonts.textButtonSize,
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  Navigator.pushNamed(context, studentVerifyRoute);
                },
                child: const Text('Sign Up',
                    style: TextStyle(
                      fontFamily: BrandFonts.fontFamily,
                      fontSize: BrandFonts.textButtonSize,
                    )),
              ),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
