import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/views/get_started.dart';
import 'package:uniconnect/views/info_views/nationality_info.dart';
import 'package:uniconnect/views/more-sign-up-info.dart';
import 'package:uniconnect/views/sign_up.dart';
import 'package:uniconnect/views/info_views/status_verified.dart';
import 'package:uniconnect/views/student_verify.dart';
import 'package:uniconnect/views/info_views/why_2_emails.dart';

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
      // home: MoreSignUpInfo(),
    
      routes: {
        '/sign-up': (context) => SignUp(),
        '/student-verify': (context) => const StudentVerify(),
        '/why-2-emails': (context) => const WhyTwoEmails(),
        '/status-verified': (context) => const StudentVerified(),
        '/why-nationality-info': (context) => const WhyNationalityInfo(),
        '/more-info-sign-up': (context) => const MoreSignUpInfo(),
      },
    );
  }
}


