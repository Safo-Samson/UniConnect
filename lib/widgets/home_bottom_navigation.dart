import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/dialogs/show_nothing.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(31, 230, 193, 231),
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 0.3,
            ),
          ),
        ),
        height: 80,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            onPressed: () {
              showNothingDialog(context,
                  '''This functionality is not available yet. The idea of the home page is to show the user a feed of posts or discussions from other students. Will be implemented soon''');
            },
            icon: const Icon(Icons.home, size: BrandFonts.iconSize),
          ),
          IconButton(
          
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, friendSuggestionsRoute, (route) => false);
            },
            icon: const Icon(Icons.person, size: BrandFonts.iconSize),
          ),
          IconButton(
            onPressed: () {
              showNothingDialog(context,
                  'This functionality is where students can join groups of students with similar interests. Will be implemented soon');
            },
            icon:
                const Icon(Icons.home_work_rounded, size: BrandFonts.iconSize),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, chatMessagesRoute, (route) => false);
            },
            icon: const Icon(Icons.message, size: BrandFonts.iconSize),
          ),
        ]));
  }
}
