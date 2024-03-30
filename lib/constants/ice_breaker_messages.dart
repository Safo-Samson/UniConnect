import 'dart:math';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniconnect/widgets/user_profile.dart';

class IceBreakerGenerator {
  final UserProfile _currentUser;
  final UserProfile _otherUser;
  final String _university = 'LSBU';

  IceBreakerGenerator(this._currentUser, this._otherUser);

  String generateIceBreakerMessage() {
    List<String> commonProfiles = [];

    // Check for nationality match
    if (_currentUser.country == _otherUser.country) {
      commonProfiles.add('same nationality');
    }
    // Check for course match
    if (_currentUser.course == _otherUser.course) {
      commonProfiles.add('same course');
    }
    // Check for year match
    if (_currentUser.year == _otherUser.year) {
      commonProfiles.add('same year');
    }

    // Generate ice breaker message based on common profiles
    String iceBreakerMessage = 'Hey ${_otherUser.username}, ';

    if (commonProfiles.isEmpty) {
      // If no common profiles found, generate a generic message
      iceBreakerMessage +=
          "I noticed we have different backgrounds, but I feel we'd make great friends. Instincts you know😂? '${moreInterestingTopics[Random().nextInt(moreInterestingTopics.length)]}'";
    } else {
      // If common profiles found, generate a personalized message
      iceBreakerMessage += "I noticed we have ";

      if (commonProfiles.length == 1) {
        iceBreakerMessage += '${commonProfiles[0]} , ';
      } else if (commonProfiles.length == 2) {
        iceBreakerMessage += '${commonProfiles[0]} and ${commonProfiles[1]} , ';
      } else {
        iceBreakerMessage +=
            ' we are both from ${_otherUser.country}, both study ${_otherUser.course}, and in ${_otherUser.year}! Now how cool is that😄? \n ';
      }

      // Add a random interesting question or topic
      List<String> interestingTopics = [
        '\nWhat do you enjoy most about $_university hub? 🏢',
        '\nWhat do you think about the $_university library? 📚',
        '\nWhat is your take the $_university meal deal?  🍔🍟🥤',
        '\nWhere you born in ${_otherUser.country} or just came to the UK for $_university? 🌍',
        '\nWhat is your favorite thing about ${_otherUser.course}? 🤔',
        "\nHow's life in ${_otherUser.year}? 🎓",
        '\nWhat are your career aspirations after graduation? 💼',
        '\nDo you have any favorite books or movies? 📖🎥',
        '\nWhat is the most exciting thing you have ever done? 🚀',
        '\nWhat\'s your favorite cuisine? 🍲',
        '\nDo you enjoy any sports or physical activities? ⚽️🏀',
        '\nWhat do you like to do in your free time? 🕰️',
        '\nWhat\'s the most memorable concert or live event you have attended? 🎤',
        '\nIf you could travel anywhere in the world, where would you go? 🌎',
        '\nWhat\'s the best piece of advice you have ever received? 💬',
        '\nDo you have any pets? 🐾',
        '\nWhat\'s your favorite season in the UK? 🌸🍂❄️☀️',
        '\nHave you ever tried any extreme sports or activities? 🏄‍♂️🪂',
        '\nWhat\'s the most interesting class or subject you have taken so far? 📝',
        '\nDo you have any favorite quotes or mottos? 💭',
        '\nWhat languages do you speak, or are interested in learning? 🗣️',
        '\nDo you have any hidden talents or unique skills? 🎭',
        '\nWhat are your favorite apps or websites for staying organized or productive? 📱💻',
        '\nWhat\'s the most adventurous thing you have ever eaten? 🍽️',
        '\nWhat are your thoughts on the latest trends or developments in technology? 💡',
      ];

      iceBreakerMessage +=
          interestingTopics[Random().nextInt(interestingTopics.length)];
    }

    return iceBreakerMessage;
  }

  String generateCommentOnTopic() {
    return moreInterestingTopics[
        Random().nextInt(moreInterestingTopics.length)];
  }
}

List<String> moreInterestingTopics = [
  '\nWhat do you enjoy most about your course? 📚',
  '\nHave you traveled to any interesting places recently? ✈️',
  '\nDo you have any favorite hobbies or activities? 🎨',
  '\nWhat are your career aspirations after graduation? 💼',
  '\nDo you have any favorite books or movies? 📖🎥',
  '\nWhat is the most exciting thing you have ever done? 🚀',
  '\nWhat\'s your favorite cuisine? 🍲',
  '\nDo you enjoy any sports or physical activities? ⚽️🏀',
  '\nWhat do you like to do in your free time? 🕰️',
  '\nWhat\'s the most memorable concert or live event you have attended? 🎤',
  '\nIf you could travel anywhere in the world, where would you go? 🌎',
  '\nWhat\'s the best piece of advice you have ever received? 💬',
  '\nDo you have any pets? 🐾',
  '\nWhat\'s your favorite season in the UK? 🌸🍂❄️☀️',
  '\nHave you ever tried any extreme sports or activities? 🏄‍♂️🪂',
  '\nWhat\'s the most interesting class or subject you have taken so far? 📝',
  '\nDo you have any favorite quotes or mottos? 💭',
  '\nWhat languages do you speak, or are interested in learning? 🗣️',
  '\nDo you have any hidden talents or unique skills? 🎭',
  '\nWhat are your favorite apps or websites for staying organized or productive? 📱💻',
  '\nWhat\'s the most adventurous thing you have ever eaten? 🍽️',
  '\nWhat are your thoughts on the latest trends or developments in technology? 💡',
  '\nWhat do you think about the LSBU hub? 🏢',
  '\nWhat do you think about the LSBU library? 📚',
  '\nWhat is your take the LSBU meal deal?  🍔🍟🥤',
];
