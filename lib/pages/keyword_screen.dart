import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notify2/boxes.dart';


class KeyScreen extends StatelessWidget {
  const KeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        appBar: AppBar(centerTitle: true,title: const Text('KEYWORDS',
          style: TextStyle(letterSpacing: 8),
        ),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
            valueListenable: keywords.listenable(),
            builder: (context, value, child) => keywords.isNotEmpty ? ListView.builder(
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 5,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(keywords.getAt(index)),
                      ElevatedButton(onPressed: (){
                        keywords.deleteAt(index);
                      }, child: const Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
              itemCount: keywords.length,
            ): const Center(child: Text("No keywords found!"),),
          
              ),
        ),floatingActionButton: FloatingActionButton.extended(
            onPressed: () => displayTextInputDialog(context),
            tooltip: 'Add keywords',
            label: const Icon(Icons.add)),);
    }
}

Future<void> displayTextInputDialog(BuildContext context) async {
  TextEditingController textFieldController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Keyword',
            textAlign: TextAlign.center,
          ),
          content: TextFormField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // print(textFieldController.text.trim());
                keywords.add(textFieldController.text.trim());
                Navigator.pop(context);
              },
              child: const Text('add'),
            )
          ],
        );
      });
}
