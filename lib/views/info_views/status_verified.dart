import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';


class StudentVerified extends StatelessWidget {
  const StudentVerified({super.key});

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
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 29, 95, 31)),
                ),
                child: const Text('Student Status Verified',
                    style: TextStyle(
                     
                      fontSize: BrandFonts.textButtonSize,
                      color: Colors.white,
                    )),
              ),
              verticalSpace(20),
              const Text(
                '''Verifying student status helps prevent imposters and ensure you are surrounded with fellow students for best experience!\n\nFew more steps to set up your account, you've got this !''',
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1.5, // Adjust the line spacing here
                  fontSize: BrandFonts.regularText,
                  
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
              Image.asset(
                'assets/img/small_confetti.png',
                height: 90,
                width: 250,
              ),
              // Image.asset('assets/img/large-confetti.png')
            ],
          ),
        ),
      ),
    );
  }
}
