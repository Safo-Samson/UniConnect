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
            child: Column(
              children: [
                ListTile(
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
                            backgroundImage:
                                NetworkImage(widget.user.imageUrl!),
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
                              widget.user.username
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
                      child: Text(widget.user.username)),
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
                buildConnectionSuggestion(currentUser, widget.user),
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
      UserProfile currentUser, UserProfile otherUser) {
    return ElevatedButton(
      onPressed: () async {
        UserProfile currentUserProfile =
            currentUser; // Use currentUser directly
        String iceBreakerMessage =
            IceBreakerGenerator.generateIceBreakerMessage(
                currentUserProfile, otherUser);
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
      UserProfile currentUser, UserProfile otherUser, String suggestionText) {
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
          _buildIceBreakerButton(currentUser, otherUser),
        ],
      ),
    );
  }

  Widget buildConnectionSuggestion(
      UserProfile currentUser, UserProfile otherUser) {
    if (currentUser.country == otherUser.country &&
        currentUser.year == otherUser.year &&
        currentUser.course == otherUser.course) {
      // Same country, year, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        "Wow, a perfect match, ${otherUser.username} is from ${otherUser.country}, in ${otherUser.year}, studying ${otherUser.course}. You should definitely connect!",
      );
    } else if (currentUser.country == otherUser.country &&
        currentUser.year == otherUser.year) {
      // Same country, year,
      return buildTextForConnection(
        currentUser,
        otherUser,
        "You have a good match with ${otherUser.username}, who is from ${otherUser.country}, and in ${otherUser.year}. Hit the ice breaker to connect with some exciting questions!",
      );
    } else if (currentUser.country == otherUser.country &&
        currentUser.course == otherUser.course) {
      // Same country, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        "${otherUser.username} is from ${otherUser.country}, and studying ${otherUser.course}. I sense a great start of friendship, connect with an ice breaker!",
      );
    } else if (currentUser.country == otherUser.country &&
        currentUser.residence != 'N/A' &&
        currentUser.residence == otherUser.residence) {
      // Same country, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        "${otherUser.username} is from ${otherUser.country}, and in the same accomodation,  ${otherUser.residence}. Good vibes in the hall don't you think? Connect with an ice breaker!",
      );
    } else if (currentUser.country == otherUser.country &&
        currentUser.residence == 'N/A' &&
        currentUser.residence == otherUser.residence) {
      // Same country, course,
      return buildTextForConnection(
        currentUser,
        otherUser,
        "${otherUser.username} is from ${otherUser.country}, and doesn't live in any student accommodation, just like you. Start your friendship from there with an ice breaker!",
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
