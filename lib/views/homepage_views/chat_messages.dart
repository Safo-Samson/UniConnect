import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/dialogs/show_nothing.dart';
import 'package:uniconnect/widgets/home_bottom_navigation.dart';

class ChatMessagePage extends StatefulWidget {
  const ChatMessagePage({Key? key}) : super(key: key);

  @override
  ChatMessagePageState createState() => ChatMessagePageState();
}

class ChatMessagePageState extends State<ChatMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 8,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black,
            fontFamily: BrandFonts.fontFamily,
              fontSize: BrandFonts.h2
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(0, 255, 255, 255),
          ),
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You currently have no messages',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNothingDialog(context,
              'This functionality is not available yet. Will be implemented soon');
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add_comment_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const HomeBottomNavigation(),
    );
  }
}
