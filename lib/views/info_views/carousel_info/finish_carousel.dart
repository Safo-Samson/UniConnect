// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/auth/auth_user.dart';
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
                    'You are all set, Welcome to Uniconnect!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: BrandFonts.h1,
                      fontWeight: FontWeight.bold,
                      
                      
                    ),
                  ),
                  verticalSpace(20),
                  Image.asset(
                    'assets/img/launch into space.jpg',
                    height: 390,
                    repeat: ImageRepeat.repeatY,
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
              onPressed: () async {
                final AuthUser user =
                    AuthService.currentAuthService().currentUser!;
                final currentUserNationality =
                    await AuthService.currentAuthService()
                        .getUserNationality(user.uid);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  friendSuggestionsRoute,
                  (route) => false,
                  arguments: currentUserNationality,
                );

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
