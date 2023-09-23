import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});


  @override
  Widget build(BuildContext context) {
  var txt = "This section is to give credit to the developers who worked on this project, but we can't share their names or other personal information because the competition rules say we can't. So, we're going to keep this information for now and add it later, once the competition is over.\n\n Thank you.";
    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(txt,style: const TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ),
    );
  }
}