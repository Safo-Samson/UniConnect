import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/widgets/home_bottom_navigation.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_container.dart';

class FriendSuggestions extends StatefulWidget {
  const FriendSuggestions({super.key});

  @override
  State<FriendSuggestions> createState() => _FriendSuggestionsState();
}

class _FriendSuggestionsState extends State<FriendSuggestions> {
  UserProfile user = UserProfile(
    username: 'Username',
    course: 'Course',
    year: 'Year',
    residence: 'Residence',
    bio: 'Bio',
    country: 'Ghana',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(252, 36, 28, 28),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(253, 255, 255, 255),
              ),
              child: Text(
                'Uniconnect',
                style: TextStyle(
                  fontSize: BrandFonts.h1,
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Handle button press
              },
            ),
            ListTile(
              title: const Text('Friends'),
              onTap: () {
                // Handle button press
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Handle button press
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                // Handle button press
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return UserProfileContainer(user: user);
              },
            ),
          ),
          const HomeBottomNavigation(),
        ],
      ),
    );
  }
}
