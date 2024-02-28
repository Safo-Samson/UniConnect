import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(253, 255, 255, 255),
        ),
        height: 100,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(Icons.home, size: BrandFonts.iconSize),
          ),
          IconButton(
          
            onPressed: () {
              Navigator.pushNamed(context, '/friends');
            },
            icon: const Icon(Icons.person, size: BrandFonts.iconSize),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.people, size: BrandFonts.iconSize),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/logout');
            },
            icon: const Icon(Icons.message, size: BrandFonts.iconSize),
          ),
        ]));
  }
}
