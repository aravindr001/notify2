import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:notify2/boxes.dart';
import 'package:notify2/model/notification.dart';
import 'package:notify2/pages/keyword_screen.dart';
import 'package:notify2/pages/message_screen.dart';
import 'package:notify2/services/local_notification.dart';



ValueNotifier<List<NotificationEvent>> log = ValueNotifier([]);
ValueNotifier<bool> started = ValueNotifier(false);
ValueNotifier<bool> loading = ValueNotifier(false);

ReceivePort port = ReceivePort();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  @override
  void initState() {
    // initPlatformState();
    super.initState();
  }

  // we must use static method, to handle in background
  static void _callback(NotificationEvent evt) {

    final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
    if (send == null) print("can't find the sender");
    send?.send(evt);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    NotificationsListener.initialize(callbackHandle: _callback);

    // this can fix restart<debug> can't handle error
    IsolateNameServer.removePortNameMapping("_listener_");
    IsolateNameServer.registerPortWithName(port.sendPort, "_listener_");
    port.listen((message) => onData(message));

    // don't use the default receivePort
    // NotificationsListener.receivePort.listen((evt) => onData(evt));

    bool? isR = await NotificationsListener.isRunning;
    print("""Service is ${isR == false ? "not " : ""}aleary running""");

    setState(() {
      started.value = isR!;
    });
  }

  void onData(NotificationEvent event) {
    setState(() {
      if (event.packageName!.contains('com.whatsapp') &&
          event.title != 'WhatsApp') {
        NotificationDataModel noti = NotificationDataModel(
            title: event.title.toString(),
            text: event.text.toString(),
            packageName: event.packageName.toString(),
            createAt: event.createAt.toString());

        notifications.add(noti);

        for (var element in keywords.values) {
          print('elements $element');
          if (event.text!.contains(element)) {
            LocalNotification.showBigTextNotification(
                title: "${event.title}",
                body: "mentioned $element in their message",
                flutterLocalNotificationsPlugin:
                    flutterLocalNotificationsPlugin);
          }
        }
      }
    });
    if (!event.packageName!.contains("example")) {
      // TODO: fix bug
      // NotificationsListener.promoteToForeground("");
    }
  }

  void startListening() async {
    print("start listening");
    setState(() {
      loading.value = true;
    });

    bool? hasPermission = await NotificationsListener.hasPermission;
    if (hasPermission == false) {
      print("no permission, so open settings");
      NotificationsListener.openPermissionSettings();
      return;
    }

    bool? isR = await NotificationsListener.isRunning;

    if (isR == false) {
      await NotificationsListener.startService(
          title: "Nofify", description: "Service started");
    }

    setState(() {
      started.value = true;
      loading.value = false;
    });
  }

  void stopListening() async {
    print("stop listening");

    setState(() {
      loading.value = true;
    });

    await NotificationsListener.stopService();

    setState(() {
      started.value = false;
      loading.value = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NOTIFIER',
            style: TextStyle(letterSpacing: 8, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions:  [
            ElevatedButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KeyScreen(),
                      ));
          }, child: const Text('Keywords'),)],      
        ),
        body: const MessageScreen(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: started.value ? stopListening : startListening,
          tooltip: 'Start/Stop sensing',
          label: loading.value
              ? const Text("Stop service") //Close
              : (started.value
                  ? const Text("Stop service")
                  : const Text("Start service")),
        ),
      ),
    );
  }
}
