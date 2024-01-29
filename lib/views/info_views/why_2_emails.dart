import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';

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
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
              verticalSpace(20),
              RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(
                  style: TextStyle(
                    height: 1.5, // Adjust the line spacing here
                    fontSize: BrandFonts.regularText,
                    fontFamily: BrandFonts.fontFamily,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'University email is to prevent imposters and ensure the app is filled with university students like yourself ',
                    ),
                    TextSpan(
                      text: '(uni email is for verification)\n\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Personal email is to avoid losing access to your account after your university ID expires',
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  Navigator.popAndPushNamed(context, '/more-info-sign-up');
                },
                child: const Text('Got it, continue',
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
