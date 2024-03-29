import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';


class WhyTwoEmails extends StatelessWidget {
  const WhyTwoEmails({super.key});

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
                'Student Vs Personal Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: BrandFonts.h1,
                  
                ),
              ),
              verticalSpace(20),
              RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(
                  style: TextStyle(
                    height: 1.5, // Adjust the line spacing here
                    fontSize: BrandFonts.regularText,
                    
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'University email is to prevent imposters and ensure the app is filled with university students like yourself ',
                      style: TextStyle(fontFamily: BrandFonts.fontFamily),
                    ),
                    TextSpan(
                      text: '(uni email is for student verification)\n\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: BrandFonts.fontFamily),
                    ),
                    TextSpan(
                      text:
                          'Personal email is to avoid losing access to your account after your university ID expires',
                      style: TextStyle(fontFamily: BrandFonts.fontFamily),
                    ),
                  ],
                ),
              ),
              verticalSpace(50),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  Navigator.popAndPushNamed(context, signupRoute);
                },
                child: const Text('Got it, continue',
                    style: TextStyle(
                      
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
