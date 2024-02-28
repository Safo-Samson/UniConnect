import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';

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
              Navigator.pushNamed(context, '/feed');
            },
            icon: const Icon(Icons.home, size: BrandFonts.iconSize),
          ),
          IconButton(
          
            onPressed: () {
              Navigator.pushNamed(context, friendSuggestionsRoute);
            },
            icon: const Icon(Icons.person, size: BrandFonts.iconSize),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/groups');
            },
            icon: const Icon(Icons.people, size: BrandFonts.iconSize),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, chatMessagesRoute);
            },
            icon: const Icon(Icons.message, size: BrandFonts.iconSize),
          ),
        ]));
  }
}
