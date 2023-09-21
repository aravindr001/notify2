import 'package:flutter/material.dart';
import 'package:notify2/constants/constants.dart';
import 'package:notify2/pages/chat_noti.dart';
import 'package:notify2/providers/chats_provider.dart';
import 'package:notify2/providers/models_provider.dart';
import 'package:provider/provider.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter ChatBOT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(
              // color: cardColor,
            )),
        home: const ChatScreen(),
      ),
    );
  }
}
