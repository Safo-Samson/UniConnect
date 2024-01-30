import 'package:uniconnect/constants/routes.dart';

const Map locationData = {
  'title': 'Grant access to your location for personalized content.',
  'image': 'assets/img/location.png',
  'description':
      'Enabling location enhances your overall experience and provides valuable benefits. By allowing your location to be turned on, you can receive personalized content tailored specifically to your geographic location. This enables the app to deliver relevant information, such as friends recommendation, trends, and more.',
  'buttonText': 'Next',
  'buttonRoute': localConnectRoute,
};

final Map localConnectData = {
  'title': 'Connect locally with students from your country or nearby...',
  'image': 'assets/img/local-connect-image.png',
  'description':
      'Connect with students from your home or nearby country with same/similar language to avoid loneliness and home sickness.',
  'buttonText': 'Next',
  'buttonRoute': globalConnectRoute,
};

final Map globalConnectData = {
  'title': '...expand globally with students all over the world',
  'image': 'assets/img/global-connect-image.png',
  'description':
      'Expand your connections with students not only from your home or nearby country , but across the globe!',
  'buttonText': 'Finish',
  'buttonRoute': finishCarouselRoute,
};

final Map finishCarouselData = {
  'title': 'You are all set!',
  'image': 'assets/img/lauch-space.jpg',
  'description':
      'Time to be apart of the students’ world, and interact with anyone, no room for loneliness !!',
  'buttonText': "Let's Explore!",
  'buttonRoute': signupRoute,
};
