import 'package:flutter/widgets.dart';
import 'package:notify2/navigator/chat.dart';
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
        imagePath: 'assets/images/homescreen/aipdfassist.png',
        name: 'AI PDF ASSIST',
      navigateScreen: ChatBot(),
        ),
    HomeList(
      imagePath: 'assets/images/homescreen/chatnotify.png',
      name : 'CHAT NOTIFY',
      navigateScreen: PdfScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/homescreen/noti.png',
      name : 'NOTI',
      navigateScreen: ChatsScreen(),
    ),
  ];
}
