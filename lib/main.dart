import 'package:flutter/material.dart';
import 'package:uniconnect/constants/carousel_info_constants.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/views/get_started.dart';
import 'package:uniconnect/views/info_views/carousel_info/finish_carousel.dart';
import 'package:uniconnect/views/info_views/carousel_info/global_connect_info.dart';
import 'package:uniconnect/views/info_views/carousel_info/local_connect_info.dart';
import 'package:uniconnect/views/info_views/carousel_info/location_info.dart';
import 'package:uniconnect/views/info_views/nationality_info.dart';
import 'package:uniconnect/views/login_view.dart';
import 'package:uniconnect/views/more-sign-up-info.dart';
import 'package:uniconnect/views/sign_or_login_view.dart';
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
      // home: const GetStarted(),
      home: const LoginOrSignUpView(),
    
      routes: {
        signupRoute: (context) => const SignUp(),
        loginRoute: (context) => const LoginView(),
        loginOrSignUpRoute: (context) => const LoginOrSignUpView(), 
        studentVerifyRoute: (context) => const StudentVerify(),
        why2EmailsRoute: (context) => const WhyTwoEmails(),
        statusVerifiedRoute: (context) => const StudentVerified(),
        whyNationalityRoute: (context) => const WhyNationalityInfo(),
        moreInfoSignUpRoute: (context) => const MoreSignUpInfo(),
        localConnectRoute: (context) =>
            LocalConnect(widgetData: localConnectData),
        globalConnectRoute: (context) =>
            GlobalConnect(widgetData: globalConnectData),
        locationInfoRoute: (context) =>
            const LocationInfo(widgetData: locationData),
        finishCarouselRoute: (context) =>
            FinishCarousel(widgetData: finishCarouselData),

        
      },
    );
  }
}


