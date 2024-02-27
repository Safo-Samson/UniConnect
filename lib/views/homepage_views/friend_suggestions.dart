import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';
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
    flag: '🇦🇷',
    country: 'Argentina',
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 8,
        title: const Text(
          'Friend Suggestions',
          style: TextStyle(
            color: Colors.black,
            fontFamily: BrandFonts.fontFamily,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(0, 255, 255, 255),
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(120.0), // Increase the height if necessary
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Based on your profile, you may like to connect with these students',
                  style: TextStyle(
                    fontFamily: BrandFonts.fontFamily,
                  ),
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.filter_alt_sharp,
                        size: BrandFonts.iconSize,
                      ),
                      onPressed: () {
                        // Handle filter button press
                      },
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'find friends...',
                          prefixIcon: const Icon(
                            Icons.search,
                            size: BrandFonts.iconSize,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle search input change
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: BrandFonts.iconSize,
            ),
            onPressed: () {
              // Handle button press
            },
          ),
        ],
      ),


      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(250, 138, 29, 189),
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
              itemCount: 10,
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
