// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uniconnect/services/cloud_crud/get_users.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';

import 'package:uniconnect/widgets/home_bottom_navigation.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_container.dart';
// import 'dart:developer' as devtols show log;

class FilteredResult extends StatefulWidget {
  final List<String> selectedNationalities;

  const FilteredResult({Key? key, required this.selectedNationalities})
      : super(key: key);

  @override
  State<FilteredResult> createState() => _FilteredResultState();
}

class _FilteredResultState extends State<FilteredResult> {
  late final FirebaseCloud _cloud;

  @override
  void initState() {
    _cloud = FirebaseCloud();
    super.initState();
  }

  @override
  void dispose() {
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
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontFamily: BrandFonts.fontFamily,
            fontSize: BrandFonts.h2,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(0, 255, 255, 255),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _cloud
                  .getUsersWithNationalities(widget.selectedNationalities),
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
                  final users = snapshot.data as List<UserProfile>;

                  if (users.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                          child: Text(
                              'Currently no users from your current filters. Please refine filters to personalize your search.')),
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
                            final user = users[index];

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