// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uniconnect/constants/ice_breaker_messages.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/dialogs/comment_dialog.dart';
import 'package:uniconnect/utils/dialogs/connect_diaglog.dart';
import 'package:uniconnect/utils/dialogs/requested_dialog.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_page.dart';

class UserProfileContainerWithIceBreaker extends StatefulWidget {
  final UserProfile user;

  UserProfileContainerWithIceBreaker({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserProfileContainerWithIceBreaker> createState() =>
      _UserProfileContainerWithIceBreakerState();
}

class _UserProfileContainerWithIceBreakerState
    extends State<UserProfileContainerWithIceBreaker> {
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
              currentUser.getRequestedUsers.contains(widget.user.getUserId);

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
            child: Column(
              children: [
                ListTile(
                  leading: widget.user.getImageUrl != null
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
                            backgroundImage:
                                NetworkImage(widget.user.getImageUrl!),
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
                              widget.user.getUsername
                                  .substring(0, 1)
                                  .toUpperCase(),
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
                      child: Text(widget.user.getUsername)),
                  subtitle: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserProfilePage(user: widget.user),
                        ),
                      );
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.user.getCourse),
                              Text(widget.user.getYear),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(widget.user.getFlag,
                                  style: const TextStyle(
                                      fontSize: BrandFonts.flagSize,
                                      color: Colors.black)),
                              Text(
                                widget.user.getCountry.substring(0, 3),
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
                                Icons.check,
                                color: BrandColor.green,
                                size: 25,
                              ),
                              const Text('Requested',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            UserProfile currentUserProfile =
                                currentUser; // Use currentUser directly
                            IceBreakerGenerator iceBreakerGenerator =
                                IceBreakerGenerator(
                                    currentUserProfile, widget.user);
                            String iceBreakerMessage =
                                iceBreakerGenerator.generateIceBreakerMessage();
                            showConnectDialog(
                              context,
                              iceBreakerMessage,
                              currentUserProfile,
                              widget.user,
                            );
                            // showCommentDialog(context);

                          },
                          child: Column(
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
                        ),
                ),
                buildConnectionSuggestion(
                    currentUser, widget.user, isConnectionRequested),
              ],
            ),  
          );
        }
      },
    );
  }

  Future<UserProfile> retrieveCurrentUser() async {
    UserProfile currentUser =
        await AuthService.currentAuthService().getCurrentUserProfile();
    return currentUser;
  }

  Widget _buildIceBreakerButton(
      UserProfile currentUser, UserProfile otherUser,
      bool isConnectionRequested) {
    return ElevatedButton(
      onPressed: isConnectionRequested
          ? null
          : () async {
        UserProfile currentUserProfile =
            currentUser; // Use currentUser directly
              IceBreakerGenerator iceBreakerGenerator =
                  IceBreakerGenerator(currentUserProfile, widget.user);
              String iceBreakerMessage =
                  iceBreakerGenerator.generateIceBreakerMessage();
        showConnectDialog(
          context,
          iceBreakerMessage,
          currentUserProfile,
          otherUser,
        );
      },
      child: const Text('Connect with Ice Breaker'),
    );
  }

  Widget buildTextForConnection(
      UserProfile currentUser, UserProfile otherUser,
      bool isConnectionRequested, String suggestionText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            suggestionText,
            style: TextStyle(
              fontSize: BrandFonts.regularText,
              color: BrandColor.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildIceBreakerButton(currentUser, otherUser, isConnectionRequested),
        ],
      ),
    );
  }

  Widget buildConnectionSuggestion(
      UserProfile currentUser,
      UserProfile otherUser, bool isConnectionRequested) {
    if (currentUser.getCountry == otherUser.getCountry &&
        currentUser.getYear == otherUser.getYear &&
        currentUser.getCourse == otherUser.getCourse) {
      // Same country, year, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        isConnectionRequested,
        isConnectionRequested
            ? "Connection has been sent to ${otherUser.getUsername}, no further action required at the moment."
            :
        "Wow, a perfect match !!!, ${otherUser.getUsername} is from ${otherUser.getCountry}, in ${otherUser.getYear}, studying ${otherUser.getCourse}. You should definitely connect!",
      );
    } else if (currentUser.getCountry == otherUser.getCountry &&
        currentUser.getYear == otherUser.getYear) {
      // Same country, year,
      return buildTextForConnection(
        currentUser,
        otherUser,
        isConnectionRequested,
        isConnectionRequested
            ? "You have already sent a connection request to ${otherUser.getUsername}, waiting for a response."
            :
        "You have a good match with ${otherUser.getUsername}, who is from ${otherUser.getCountry}, and in ${otherUser.getYear}. Hit the ice breaker to connect with some exciting questions!",
      );
    } else if (currentUser.getCountry == otherUser.getCountry &&
        currentUser.getCourse == otherUser.getCourse) {
      // Same country, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        isConnectionRequested,
        isConnectionRequested
            ? "Your request was sent to ${otherUser.getUsername}, nothing else is required from you"
            :
        "${otherUser.getUsername} is from ${otherUser.getCountry}, and studying ${otherUser.getCourse}. I sense a great start of friendship, connect with an ice breaker!",
      );
    } else if (currentUser.getCountry == otherUser.getCountry &&
        currentUser.getResidence != 'N/A' &&
        currentUser.getResidence == otherUser.getResidence) {
      // Same country, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        isConnectionRequested,
        isConnectionRequested
            ? "${otherUser.getUsername} has already received your connection request. Please wait for a response."
            :
        "${otherUser.getUsername} is from ${otherUser.getCountry}, and in the same accomodation,  ${otherUser.getResidence}. Good vibes in the hall don't you think? Connect with an ice breaker!",
      );
    } else if (currentUser.getCountry == otherUser.getCountry &&
        currentUser.getResidence == 'N/A' &&
        currentUser.getResidence == otherUser.getResidence) {
      // Same country, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        isConnectionRequested,
        isConnectionRequested
            ? "You have already sent a connection request to ${otherUser.getUsername}."
            :
        "${otherUser.getUsername} is from ${otherUser.getCountry}, and doesn't live in any student accommodation, just like you. Start your friendship from there with an ice breaker!",
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
