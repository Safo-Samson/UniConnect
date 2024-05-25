// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/utils/helpers_utilities/random_letter.dart';

class GroupContainer extends StatefulWidget {
  final String groupName;
  final String numberOfMembers;
  final String? imageSource; // Optional image source

  GroupContainer({
    Key? key,
    required this.groupName,
    required this.numberOfMembers,
    this.imageSource, // Optional parameter
  }) : super(key: key);

  @override
  State<GroupContainer> createState() => _GroupContainerState();
}

class _GroupContainerState extends State<GroupContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: BrandColor.primary),
        ),
      ),
      child: ListTile(
        leading: widget.imageSource != null
            ? Image.asset(
                widget.imageSource!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 50,
                  height: 50, // Adjust the height as needed
                  color: BrandColor.primary,
                  child: const Icon(Icons.people, color: Colors.white),
                ),
              ),
        title: Text("LSBU ${widget.groupName}"),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.numberOfMembers} students"),
                verticalSpace(5.0),
                _buildAvatarStack(),
              ],
            ),
          ],
        ),
        trailing: null,
      ),
    );
  }

  Widget _buildAvatarStack() {
    final List<Widget> avatars = List.generate(3, (index) {
      return CircleAvatar(
        backgroundColor: const Color.fromARGB(179, 158, 158, 158),
        radius: 15,
        child: Text(
          generateRandomUppercaseLetter(),
          style: TextStyle(
            color: BrandColor.white,
          ),
        ),
      );
    });

    return Row(
      children: [
        ...avatars,
        const Text(
          '...', // Ellipsis
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
