import 'dart:math';

import 'package:uniconnect/widgets/user_profile.dart';

class IceBreakerGenerator {
  static String generateIceBreakerMessage(
      UserProfile currentUser, UserProfile otherUser) {
    // Check for common matching profiles
    List<String> commonProfiles = [];

    // Check for nationality match
    if (currentUser.country == otherUser.country) {
      commonProfiles.add('same nationality');
    }

    // Check for course match
    if (currentUser.course == otherUser.course) {
      commonProfiles.add('same course');
    }

    // Check for year match
    if (currentUser.year == otherUser.year) {
      commonProfiles.add('same year');
    }

    // Generate ice breaker message based on common profiles
    String iceBreakerMessage = 'Hey ${otherUser.username}, ';

    if (commonProfiles.isEmpty) {
      // If no common profiles found, generate a generic message
      iceBreakerMessage +=
          "I noticed we have different backgrounds, but I feel we'd make great friends. Instincts 😂 you know? How do you find LSBU and ${otherUser.course} ?";
    } else {
      // If common profiles found, generate a personalized message
      iceBreakerMessage += "I noticed we have ";

      if (commonProfiles.length == 1) {
        iceBreakerMessage += '${commonProfiles[0]} , ';
      } else if (commonProfiles.length == 2) {
        iceBreakerMessage += '${commonProfiles[0]} and ${commonProfiles[1]} , ';
      } else {
        iceBreakerMessage +=
            ' we are both from ${otherUser.country}, both study ${otherUser.course}, and in ${otherUser.year}! Now how cool is that😄? \n ';
      }

      // Add a random interesting question or topic
      List<String> interestingTopics = [
        '\nWhat do you enjoy most about your course?',
        '\nHave you traveled to any interesting places recently?',
        '\nDo you have any favorite hobbies or activities?',
        '\nWhat are your career aspirations after graduation?',
        '\nDo you have any favorite books or movies?',
        '\nWhat is the most exciting thing you have ever done?',
        '\nWhere you born in ${otherUser.country} or just came to the UK for University?',
        '\nWhat is your favorite thing about ${otherUser.course}?',
        "\nHow's life in ${otherUser.year}?",
      ];

      iceBreakerMessage +=
          '${interestingTopics[Random().nextInt(interestingTopics.length)]}?';
    }

    return iceBreakerMessage;
  }
}
