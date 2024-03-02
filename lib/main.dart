
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/constants/carousel_info_constants.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/views/get_started.dart';
import 'package:uniconnect/views/homepage_views/apply_filters.dart';
import 'package:uniconnect/views/homepage_views/chat_messages.dart';
import 'package:uniconnect/views/homepage_views/filtered_results.dart';
import 'package:uniconnect/views/homepage_views/friend_suggestions.dart';
import 'package:uniconnect/views/info_views/carousel_info/finish_carousel.dart';
import 'package:uniconnect/views/info_views/carousel_info/global_connect_info.dart';
import 'package:uniconnect/views/info_views/carousel_info/local_connect_info.dart';
import 'package:uniconnect/views/info_views/carousel_info/location_info.dart';
import 'package:uniconnect/views/info_views/nationality_info.dart';
import 'package:uniconnect/views/login_view.dart';
import 'package:uniconnect/views/more_sign_up_info.dart';
import 'package:uniconnect/views/sign_or_login_view.dart';
import 'package:uniconnect/views/sign_up.dart';
import 'package:uniconnect/views/info_views/status_verified.dart';
import 'package:uniconnect/views/student_verify.dart';
import 'package:uniconnect/views/info_views/why_2_emails.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'package:uniconnect/widgets/user_profile_page.dart';
// import 'dart:developer' as devtols show log;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Require that the Flutter app is initialized before running the app
  await AuthService.firebase().initialize(); // Initialize the firebase app
  runApp(const HomePage());
}

UserProfile user1 = UserProfile(
  username: 'John Doe',
  course: 'Computer Science',
  year: '1st Year',
  residence: 'Kilifi',
  country: 'Kenya',
  flag: '🇰🇪',
  imageUrl: 'https://safosamson.me/assets/img/star%20of%20the%20week.jpg',
  bio: 'I am a Computer Science student at Pwani University',
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: BrandColor.primary as MaterialColor,
        fontFamily: BrandFonts.fontFamily,
      ),
      // home: const GetStarted(),
      home: const FriendSuggestions(),

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
        finishCarouselRoute: (context) => const FinishCarousel(),
        friendSuggestionsRoute: (context) => const FriendSuggestions(),
        chatMessagesRoute: (context) => const ChatMessagePage(),
        applyFiltersRoute: (context) => const ApplyFilters(),
      
        filteredResultsRoute: (context) {
          final List<dynamic> args =
              ModalRoute.of(context)!.settings.arguments as List<dynamic>;
          final List<String> selectedNationalities = args[0] as List<String>;
          final List<String> selectedResidents = args[1] as List<String>;
          final List<String> selectedCourses = args[2] as List<String>;
          final List<String> selectedYears = args[3] as List<String>;

          return FilteredResult(
            selectedNationalities: selectedNationalities,
            selectedResidents: selectedResidents,
            selectedCourses: selectedCourses,
            selectedYears: selectedYears,
          );
        },
      
        viewProfileRoute: (context) {
          final UserProfile user =
              ModalRoute.of(context)!.settings.arguments as UserProfile;
          return UserProfilePage(user: user);
        },

        
      },
    );
  }
}

