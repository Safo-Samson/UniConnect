import 'package:flutter/material.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/auth/auth_user.dart';
import 'package:uniconnect/services/cloud_crud/get_users.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/widgets/home_bottom_navigation.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_container.dart';
import 'dart:developer' as devtols show log;

class FriendSuggestions extends StatefulWidget {
  const FriendSuggestions({super.key});

  @override
  State<FriendSuggestions> createState() => _FriendSuggestionsState();
}

class _FriendSuggestionsState extends State<FriendSuggestions> {
  late final FirebaseCloud _cloud;
  late String currentUserNationality;

  final AuthUser user = AuthService.firebase().currentUser!;


  Future<void> initializeData() async {
    _cloud = FirebaseCloud();
    // Retrieve user's nationality and assign it to currentUserNationality
    currentUserNationality =
        await AuthService.firebase().getUserNationality(user.uid);

    devtols.log(currentUserNationality);
    setState(() {
      // Call setState to rebuild the widget tree with the fetched nationality
    });
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  void dispose() {
    // _cloud.dispose();
    super.dispose();
  }



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
                AuthService.firebase().signOut();
                Navigator.pushReplacementNamed(context, loginRoute);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _cloud.getUsersWithNationality(currentUserNationality),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching users'),
                  );
                }

                if (snapshot.hasData) {
                  final users = snapshot.data as Iterable<UserProfile>;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = users.elementAt(index);

                      return UserProfileContainer(user: user);
                    },
                  );
                }
                return const Center(
                  child: Text('No users found'),
                );
              },
            ),
          ),
          const HomeBottomNavigation(),
        ],
      ),
    );
  }
}
