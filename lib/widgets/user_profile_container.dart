// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/widgets/user_profile.dart';


class UserProfileContainer extends StatefulWidget {
  UserProfile user;
  UserProfileContainer({super.key, required this.user});

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
        leading: const CircleAvatar(
          // You can set the user's profile picture here
          child: Text('U'), // Example: Display the first letter of the username
        ),

        title: Text(widget.user.username),

        subtitle:
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
                  style: const TextStyle(fontSize: 17, color: Colors.black)),
              Text(
                widget.user.country.substring(0, 3),
                style: const TextStyle(color: Colors.black),
                
              ),
            ],
          ),
      
        ]),
        

        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
            // SizedBox(height: 2),
            Text('Connect',
                style:
                    TextStyle(fontSize: 12)), // Adjust the font size as needed
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
