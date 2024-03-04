// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uniconnect/constants/ice_breaker_messages.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/dialogs/connect_diaglog.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_page.dart';

class UserProfileContainer extends StatefulWidget {
  UserProfile user;
  String iceBreakerMessage;
  // final IceBreakerGenerator iceBreakerGenerator = IceBreakerGenerator();
  UserProfileContainer(
      {super.key, required this.user, this.iceBreakerMessage = ""});

  @override
  State<UserProfileContainer> createState() => _UserProfileContainerState();
}

class _UserProfileContainerState extends State<UserProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: BrandColor.primary, // Set the color of the border
          width: 2.0, // Set the width of the border
        ),
      ),
      child: ListTile(
        leading: widget.user.imageUrl != null
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfilePage(user: widget.user),
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
                      builder: (context) => UserProfilePage(user: widget.user),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(179, 158, 158, 158),
                  child: Text(
                    widget.user.username.substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
        title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(user: widget.user),
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                        fontSize: BrandFonts.flagSize, color: Colors.black)),
                Text(
                  widget.user.country.substring(0, 3),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ]),
        ),
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
            Text('Connect', style: TextStyle(fontSize: 12)),
          ],
        ),
        onTap: () async {
          UserProfile currentUserProfile =
              await AuthService.firebase().getCurrentUserProfile();

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
}
