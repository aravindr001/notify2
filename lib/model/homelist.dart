// import 'package:best_flutter_ui_templates/design_course/home_design_course.dart';
// import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
// import 'package:best_flutter_ui_templates/hotel_booking/hotel_home_screen.dart';
// import 'package:best_flutter_ui_templates/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:notify2/navigator/chat.dart';
import 'package:notify2/pages/chat_noti.dart';
import 'package:notify2/pages/chat_screen.dart';
import 'package:notify2/pages/pdf_screen.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
    this.name = ''
  });

  Widget? navigateScreen;
  String imagePath;
  String name;

  static List<HomeList> homeList = [
    HomeList(
        imagePath: 'assets/images/homescreen/pdftotext.jpg',
        name: 'Chat with Noti',
        navigateScreen: ChatBot(),
        ),
    // HomeList(
    //   imagePath: 'assets/images/homescreen/imagetotext.jpg',
    //   name : 'AI Image to text'
    //   // navigateScreen: IntroductionAnimationScreen(),
    //   // navigateScreen: IntroductionAnimationScreen(),
    // ),
    HomeList(
      imagePath: 'assets/images/homescreen/pdftotext.jpg',
      name : 'AI pdf summarizer',
      navigateScreen: PdfScreen(),
    ),
    // HomeList(
    //   imagePath: 'assets/images/homescreen/audiotranscriber.jpg',
    //   name : 'AI Audio transcriber'
    //   // navigateScreen: FitnessAppHomeScreen(),
    // ),
    HomeList(
      imagePath: 'assets/images/homescreen/chats.jpg',
      name : 'AI Chat',
      navigateScreen: ChatsScreen(),
    ),
  ];
}
