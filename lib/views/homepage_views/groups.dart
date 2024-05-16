// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uniconnect/constants/notification_list.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/database_cloud/database_service.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/widgets/group_container.dart';
import 'package:uniconnect/widgets/home_bottom_navigation.dart';
import 'package:uniconnect/widgets/user_profile.dart';

import 'dart:developer' as devtols show log;

class Groups extends StatefulWidget {
  final String currentUserNationality;
  final String currentUserResidence;
  final String currentUserCourse;
  const Groups(
      {Key? key,
      required this.currentUserNationality,
      required this.currentUserResidence,
      required this.currentUserCourse})
      : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  late String currentUserNationality = widget.currentUserNationality;
  late String currentUserResidence = widget.currentUserResidence;
  late String currentUserCourse = widget.currentUserCourse;

  @override
  Widget build(BuildContext context) {
    bool hasNotifications = notifications.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 8,
        title: const Text(
          'Student groups',
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
                  'You have been automatically added to groups based on your profile',
                  style: TextStyle(),
                ),
                verticalSpace(10),
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.wait([
                DatabaseService.currentDatabaseService()
                    .getUsersWithNationality(currentUserNationality),
                DatabaseService.currentDatabaseService()
                    .getUsersWithCourse(currentUserCourse),
                DatabaseService.currentDatabaseService()
                    .getUsersWithResidence(currentUserResidence),
              ]),
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
                  devtols.log(snapshot.error.toString());

                  return Center(
                    child: Text(
                        'Error fetching groups ${snapshot.error.toString()}'),
                  );
                }

                if (snapshot.hasData) {
                  final List<Iterable<UserProfile>> usersLists =
                      snapshot.data as List<Iterable<UserProfile>>;
                  final List<int> userCounts =
                      usersLists.map((users) => users.length).toList();

                  final nationalityGroupCount = userCounts[0].toString();
                  final courseGroupCount = userCounts[1].toString();
                  final residenceGroupCount = userCounts[2].toString();

                  return Column(
                    children: [
                      GroupContainer(
                        groupName: currentUserNationality,
                        numberOfMembers: nationalityGroupCount,
                      ),
                      GroupContainer(
                        groupName: currentUserCourse,
                        numberOfMembers: courseGroupCount,
                      ),
                      GroupContainer(
                        groupName: currentUserResidence,
                        numberOfMembers: residenceGroupCount,
                        // imageSource:
                        //     'assets/img/halls/$currentUserResidence.png',
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text('No groups found'),
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
