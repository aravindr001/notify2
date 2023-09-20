import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notify2/boxes.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
      child: ValueListenableBuilder(
          valueListenable: notifications.listenable(),
          builder: (context, value, child) => ListView.separated(
                reverse: true,
                itemBuilder: (BuildContext context, int idx) {
                  final entry = notifications.getAt(idx);
                  print(entry);
                  return Card(
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.bottom,
                      title: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(entry.title ?? "<<no title>>"),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(entry.text.toString()),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(entry.packageName.toString().split('.').last),
                          // Text(entry.createAt.toString().substring(0, 19)),
                          Text(entry.createAt.toString().substring(10, 19)),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: notifications.length,
              )),
    );
  }
}
