// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

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

  const ConnectDialog({
    Key? key,
    required this.iceBreakerMessage,
    required this.currentUser,
    required this.otherUser,
  }) : super(key: key);

  @override
  _ConnectDialogState createState() => _ConnectDialogState();
}

class _ConnectDialogState extends State<ConnectDialog>
    with SingleTickerProviderStateMixin {
  late TextEditingController _textEditingController;
  bool _isEditing = false;
  late int _charCount;
  final int maxCharCount = 500;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.iceBreakerMessage);
    _charCount = widget.iceBreakerMessage.length;

    // Add listener to the TextEditingController to update character count
    _textEditingController.addListener(_updateCharCount);

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _animationController.dispose();
    super.dispose();
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

  // Method to handle sending message animation
  void _startSendingAnimation() {
    setState(() {
      _isSending = true;
    });

    _animationController.forward().then((_) {
      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pop(); // Dismiss dialog after animation completes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Connect with Ice Breaker",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: BrandFonts.h1),
      ),
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
                      fontSize: BrandFonts.regularText,
                      height: 1.3,
                    ),
                    maxLines: null, // Allow multiple lines
                    maxLength: maxCharCount, // Set maximum character length
                    decoration: const InputDecoration(
                      hintText: 'Type a message to connect',
                      counter: SizedBox.shrink(),
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
                      onPressed: _isEditing
                          ? null
                          : () {
                              String newIceBreakerMessage =
                                  generateIceBreakerMessage();
                              setState(() {
                                _textEditingController.text =
                                    newIceBreakerMessage;
                                _charCount = newIceBreakerMessage.length;
                              });
                            },
                      icon: const Icon(Icons.sync_outlined),
                      tooltip: 'Generate Ice Breaker',
                    ),
                    const Text('Regenerate',
                        style: TextStyle(fontSize: BrandFonts.regularText)),
                  ],
                ),
                Text(
                  '$_charCount/$maxCharCount',
                  style: TextStyle(
                    color: _charCount == maxCharCount ? Colors.red : null,
                  ),
                ),
              ],
            ),
            verticalSpace(20),
            if (_isSending)
              ScaleTransition(
                scale: _animation,
                child: Column(
                  children: [
                    Icon(Icons.done_all_sharp,
                        color: BrandColor.green, size: 50),
                    Text('Request Sent',
                        style:
                            TextStyle(color: BrandColor.green, fontSize: 20)),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Connect Using...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: BrandFonts.h2,
                        fontWeight: FontWeight.bold,
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
                                      _charCount > maxCharCount
                                  ? null
                                  : () {
                                      // Handle sending the message
                                      _startSendingAnimation();
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
                                _startSendingAnimation();
                              },
                              icon: const Icon(
                                  Icons.cancel_schedule_send_rounded),
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
        otherUser: otherUser,
      );
    },
  );
}
