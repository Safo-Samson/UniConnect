// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uniconnect/constants/ice_breaker_messages.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/dialogs/connect_diaglog.dart';
import 'package:uniconnect/utils/dialogs/requested_dialog.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_page.dart';

class UserProfileContainer extends StatefulWidget {
  final UserProfile user;

  UserProfileContainer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserProfileContainer> createState() => _UserProfileContainerState();
}

class _UserProfileContainerState extends State<UserProfileContainer> {
  late Future<UserProfile> _currentUserFuture;

  @override
  void initState() {
    super.initState();
    _currentUserFuture = retrieveCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile>(
      future: _currentUserFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitChasingDots(
            color: BrandColor.primary,
            size: 2.0,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final currentUser = snapshot.data!;
          bool isConnectionRequested =
              currentUser.requestedUsers.contains(widget.user.userId);

          return Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: BrandColor.primary,
                width: 2.0,
              ),
            ),
            child: ListTile(
              leading: widget.user.imageUrl != null
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserProfilePage(user: widget.user),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.user.imageUrl!),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserProfilePage(user: widget.user),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(179, 158, 158, 158),
                        child: Text(
                          widget.user.username.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
              title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserProfilePage(user: widget.user),
                      ),
                    );
                  },
                  child: Text(widget.user.username)),
              subtitle: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfilePage(user: widget.user),
                    ),
                  );
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.user.course),
                          Text(widget.user.year),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.user.flag,
                              style: const TextStyle(
                                  fontSize: BrandFonts.flagSize,
                                  color: Colors.black)),
                          Text(
                            widget.user.country.substring(0, 3),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ]),
              ),
              trailing: isConnectionRequested
                  ? GestureDetector(
                      onTap: () {
                        showRequestSentDialog(context,
                            'You have already sent a connection request to this user. No action required.');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: BrandColor.black,
                            size: 22,
                          ),
                          const Text('Requested',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: BrandColor.black,
                          size: 30,
                        ),
                        const Text('Connect   ',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
              onTap: () async {
                UserProfile currentUserProfile =
                    currentUser; // Use currentUser directly
                String iceBreakerMessage =
                    IceBreakerGenerator.generateIceBreakerMessage(
                        currentUserProfile, widget.user);
                showConnectDialog(
                  context,
                  iceBreakerMessage,
                  currentUserProfile,
                  widget.user,
                );
              },
            ),
          );
        }
      },
    );
  }

  Future<UserProfile> retrieveCurrentUser() async {
    UserProfile currentUser =
        await AuthService.firebase().getCurrentUserProfile();
    return currentUser;
  }
}
