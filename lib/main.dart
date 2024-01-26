import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/views/get_started.dart';
import 'package:uniconnect/views/sign_up.dart';
import 'package:uniconnect/views/student_verify.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: BrandColor.primary as MaterialColor,
      ),
      home: const GetStarted(),
      routes: {
        '/sign-up': (context) => SignUp(),
        '/student-verify': (context) => const StudentVerify(),
      },
    );
  }
}


