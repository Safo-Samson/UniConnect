import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';



class FinishCarousel extends StatelessWidget {
  const FinishCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text(
                    'You are all set!',
                    style: TextStyle(
                      fontSize: BrandFonts.h1,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                  verticalSpace(20),
                  Image.asset(
                    'assets/img/lauch-space.jpg',
                    width: 250,
                    height: 190,
                  ),
                  verticalSpace(20),
                  const Text(
                    'Time to be apart of the students’ world, and interact with anyone, no room for loneliness !!',
                    style: TextStyle(
                      fontSize: BrandFonts.regularText,
                     
                    ),
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, friendSuggestionsRoute, (route) => false);
              },
              child: const Text(
                "Let's Explore!",
                style: TextStyle(fontSize: BrandFonts.textButtonSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
