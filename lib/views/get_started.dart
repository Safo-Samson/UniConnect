
import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';

import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';
// import 'dart:developer' as devtols show log;

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  double opacity = 0.0; // Initial opacity value
  
  @override
  void initState() {
    super.initState();

    // addTestData(); // Add test data to Firestore

    // Start the animation sequence after a delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0; // Set opacity to 1 after one second
      
      });
    });
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: opacity,
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
              AnimatedOpacity(
                duration: const Duration(seconds: 3),
                opacity: opacity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    Navigator.popAndPushNamed(context, studentVerifyRoute);
                  },
                  child: const Text('Get Started',
                      style: TextStyle(
                        fontFamily: BrandFonts.fontFamily,
                        fontSize: BrandFonts.textButtonSize,
                      )),
                ),
              ),
              verticalSpace(20),
              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: opacity,
                child: Image.asset('assets/img/grads.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
