// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uniconnect/constants/notification_list.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/auth/auth_user.dart';
import 'package:uniconnect/services/database_cloud/database_service.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/utils/dialogs/logout_dialog.dart';
import 'package:uniconnect/utils/dialogs/show_nothing.dart';
import 'package:uniconnect/widgets/home_bottom_navigation.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_container.dart';
import 'package:uniconnect/widgets/user_profile_page.dart';
// import 'dart:developer' as devtols show log;

class FriendSuggestions extends StatefulWidget {
  final String currentUserNationality;

  const FriendSuggestions({Key? key, required this.currentUserNationality})
      : super(key: key);

  @override
  State<FriendSuggestions> createState() => _FriendSuggestionsState();
}


class _FriendSuggestionsState extends State<FriendSuggestions> {

  late String currentUserNationality = widget.currentUserNationality;

  final AuthUser user = AuthService.firebase().currentUser!;

  @override
  Widget build(BuildContext context) {

    bool hasNotifications = notifications.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 8,
        title: const Text(
          'Friend Suggestions',
          style: TextStyle(
            color: Colors.black,
            fontSize: BrandFonts.h2,
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
                  'Based on your profile, you may like to connect with these students.',
                  style: TextStyle(),
                ),
                verticalSpace(10),
                Divider(
                  color: BrandColor.grey,
                  thickness: 1,
                ),
                // verticalSpace(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Filter and personalize your search ',
                        style: TextStyle(fontSize: BrandFonts.regularText)),
                    IconButton(
                      icon: const Icon(
                        Icons.filter_alt_sharp,
                        size: BrandFonts.iconSize,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, applyFiltersRoute);
                      },
                    ),
                    // Expanded(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       hintText: 'find friends...',
                    //       prefixIcon: const Icon(
                    //         Icons.search,
                    //         size: BrandFonts.iconSize,
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //       ),
                    //     ),
                    //     onChanged: (value) {
                    //       // Handle search input change
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              hasNotifications
                  ? Icons.notifications_active
                  : Icons.notifications,
              size: BrandFonts.iconSize,
              color: hasNotifications ? Colors.red : null,
            ),
            onPressed: () {
             
              Navigator.pushNamed(
                context,
                notificationRoute,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(192, 156, 50, 206),
              ),
              child: Text(
                'UniConnect',
                style: TextStyle(
                  fontSize: BrandFonts.h1,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person), // Icon for My Profile
              title: const Text('My Profile'),
              onTap: () async {
                final userProfile =
                    await AuthService.firebase().getCurrentUserProfile();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(user: userProfile),
                  ),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.notifications), // Icon for Notifications
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pushNamed(context, notificationRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings), // Icon for Settings
              title: const Text('Settings'),
              onTap: () {
                showNothingDialog(context,
                    'This feature is not available yet. I am working on it.');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout), // Icon for Log Out
              title: const Text('Log Out'),
              onTap: () async {
                final result = await showLogoutDialog(context);
                if (result) {
                  AuthService.firebase().signOut();
                  Navigator.pushReplacementNamed(context, loginRoute);
                }
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: DatabaseService.firebasefirestore()
                  .getUsersWithNationality(currentUserNationality),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      color: BrandColor.primary,
                      size: 50,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching users'),
                  );
                }

                if (snapshot.hasData) {
                  final users = snapshot.data as Iterable<UserProfile>;

                  if (users.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: BrandFonts.regularText,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Currently no users from ',
                              ),
                              TextSpan(
                                text: currentUserNationality,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    '. Please apply filters to personalize your search.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  // Heading to display the number of users
                  Widget userList = Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Showing ${users.length} users',
                          style: const TextStyle(
                            fontSize: BrandFonts.h1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            final user = users.elementAt(index);

                            return UserProfileContainer(user: user);
                          },
                        ),
                      ),
                    ],
                  );

                  return userList;
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
