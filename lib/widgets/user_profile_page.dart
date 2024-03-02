import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/widgets/user_profile.dart'; // Import the UserProfile class

class UserProfilePage extends StatefulWidget {
  final UserProfile user;

  const UserProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.user.username), // Set the title to the user's username
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Info Section
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image and Username
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Image
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey, // Placeholder color
                            image: widget.user.imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(widget.user.imageUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null, // Use null if imageUrl is not available
                          ),
                          child: widget.user.imageUrl == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    widget.user.username
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 40.0, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : null, // Hide the CircleAvatar if imageUrl is available
                        ),

                        verticalSpace(10),
                        // Username
                        Text(
                          widget.user.username,
                          style: const TextStyle(
                            fontSize: BrandFonts.h1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(20), // Add spacing between image and details
                  // Course and Year, Flag and Country
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Course and Year
                        Text(
                          widget.user.course,
                          style: TextStyle(
                            fontSize: BrandFonts.regularText,
                            color: BrandColor.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace(10),
                        Text(
                          widget.user.year,
                          style: TextStyle(
                            fontSize: BrandFonts.regularText,
                            color: BrandColor.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace(10),
                        // Flag and Country
                        Text(
                          '${widget.user.flag} - ${widget.user.country}',
                          style: TextStyle(
                              fontSize: BrandFonts.regularText,
                              color: BrandColor.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace(10),
                        Row(
                          children: [
                            const Icon(
                              Icons.assured_workload_outlined,
                              color: Colors.black,
                              size: BrandFonts.regularText,
                            ),
                            horizontalSpace(5),
                            const Text('- LSBU',
                                style: TextStyle(
                                    fontSize: BrandFonts.regularText)),
                            verticalSpace(10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bio
            if (widget.user.bio != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(widget.user.bio!),
              ),
            // Divider
            const Divider(),
            // Additional Sections (Posts, Followers, Following, etc.)
            // You can customize this section based on the specific requirements
            // For simplicity, let's just display a text for now
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'This is where you can display additional sections like Posts, Followers, Following, etc.',
                style: TextStyle(
                  fontSize: BrandFonts.regularText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
