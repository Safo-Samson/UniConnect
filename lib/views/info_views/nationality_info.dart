import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';


class WhyNationalityInfo extends StatelessWidget {
  const WhyNationalityInfo({super.key});

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
                'Why Ask For Nationality?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: BrandFonts.h1,
                 
                ),
              ),
              verticalSpace(20),
              const Text(
                '''This will be a key feature to help students (particularly international) to easily find other students from their country on the app to foster interaction.\nAdditionally, it will help filter for friends of a specific nationality.\n\nIf you have dual nationality, use any!''',
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1.5, // Adjust the line spacing here
                  fontSize: BrandFonts.regularText,
                  
                ),
              ),
              verticalSpace(20),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  Navigator.pushNamed(context, moreInfoSignUpRoute);
                },
                child: const Text('Okay, got it!',
                    style: TextStyle(
                      
                      fontSize: BrandFonts.textButtonSize,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
