// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:uniconnect/constants/ice_breaker_messages.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/widgets/user_profile.dart';

class ConnectDialog extends StatefulWidget {
  final String iceBreakerMessage;
  final UserProfile currentUser;
  final UserProfile otherUser;

  const ConnectDialog(
      {Key? key,
      required this.iceBreakerMessage,
      required this.currentUser,
      required this.otherUser})
      : super(key: key);

  @override
  _ConnectDialogState createState() => _ConnectDialogState();
}

class _ConnectDialogState extends State<ConnectDialog> {
  late TextEditingController _textEditingController;
  bool _isEditing = false;
  late int _charCount;
  final int maxCharCount = 500;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.iceBreakerMessage);
    _charCount = widget.iceBreakerMessage.length;

    // Add listener to the TextEditingController to update character count
    _textEditingController.addListener(_updateCharCount);
  }

  // Method to update the character count
  void _updateCharCount() {
    setState(() {
      _charCount = _textEditingController.text.length;
    });
  }

  // Method to generate a new ice breaker message
  String generateIceBreakerMessage() {
    return IceBreakerGenerator.generateIceBreakerMessage(
        widget.currentUser, widget.otherUser);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Connect with Ice Breaker",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: BrandFonts.h1)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textEditingController,
                    autofocus: true,
                    readOnly: !_isEditing,
                    style: const TextStyle(
                        fontSize: BrandFonts.regularText, height: 1.3),
                    maxLines: null, // Allow multiple lines
                    maxLength: maxCharCount, // Set maximum character length
                    decoration: const InputDecoration(
                      hintText: 'Type a message to connect',
                      counter: SizedBox
                          .shrink(), // Hide the default character counter
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  icon: Icon(_isEditing ? Icons.save : Icons.edit),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Generate new ice breaker message
                        String newIceBreakerMessage =
                            generateIceBreakerMessage();
                        setState(() {
                          _textEditingController.text = newIceBreakerMessage;
                          _charCount = newIceBreakerMessage.length;
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Generate Ice Breaker',
                    ),
                    const Text('Regenerate',
                        style: TextStyle(fontSize: BrandFonts.regularText)),
                  ],
                ),
                Text(
                  '$_charCount/$maxCharCount', // Use _charCount variable for dynamic count
                  style: TextStyle(
                      color: _charCount == maxCharCount ? Colors.red : null),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(
                  10), 
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Set border color
                  width: 1, // Set border width
                ),
                borderRadius: BorderRadius.circular(10), // Set border radius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Connect Using...',
                    style: TextStyle(
                      fontSize: BrandFonts.h2,
                      fontWeight: FontWeight.bold, // Make the heading bold
                    ),
                  ),
                  verticalSpace(10),
                  Divider(
                    color: BrandColor.grey,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.send),
                            tooltip: 'Connect with Ice Breaker',
                            disabledColor: BrandColor.grey,
                            onPressed: _textEditingController.text.isEmpty ||
                                    _isEditing ||
                                    _charCount >
                                        maxCharCount // Disable if message is empty, being edited, or exceeds max length
                                ? null
                                : () {
                                    // Handle sending the message
                                  },
                          ),
                          const Text('Ice Breaker'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Handle connecting without ice breaker
                            },
                            icon:
                                const Icon(Icons.cancel_schedule_send_rounded),
                            tooltip: 'Connect without Ice Breaker',
                          ),
                          const Text('No Ice Breaker'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showConnectDialog(BuildContext context, String iceBreakerMessage,
    UserProfile currentUser, UserProfile otherUser) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConnectDialog(
          iceBreakerMessage: iceBreakerMessage,
          currentUser: currentUser,
          otherUser: otherUser);
    },
  );
}
