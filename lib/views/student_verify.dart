import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';

class StudentVerify extends StatelessWidget {
  const StudentVerify({super.key});

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
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo ss.png', height: 100, width: 200),
            verticalSpace(25),
            const Text(
              'Connect locally, expand globally with other students',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: BrandFonts.h1,
                  fontFamily: BrandFonts.fontFamily),
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
            const TextField(
              decoration: InputDecoration(
                hintText: 'example@lsbu.ac.uk',
                border: OutlineInputBorder(),
                labelText: 'email',
              ),
            ),
            verticalSpace(20),
            ElevatedButton(
              onPressed: () {
                // Handle button press
                Navigator.pushReplacementNamed(context, '/sign-up');
              },
              child: const Text('Verify',
                  style: TextStyle(
                    fontSize: BrandFonts.textButtonSize,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
