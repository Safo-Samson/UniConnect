import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';

class CommentDialog extends StatelessWidget {
  const CommentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Comment on this Ice Breaker',
        style: TextStyle(
          fontSize: BrandFonts.h1,
        ),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How do you find the computers in the LSBU Hub?',
            style: TextStyle(
                fontSize: BrandFonts.regularText, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              hintText: 'Type your comment here...',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Implement action here
            Navigator.of(context).pop();
          },
          child: const Text('Send'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

// Show dialog
void showCommentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CommentDialog();
    },
  );
}
