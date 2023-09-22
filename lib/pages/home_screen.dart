import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:notify2/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:notify2/boxes.dart';
import 'package:notify2/model/homelist.dart';
import 'package:notify2/model/notification.dart';
import 'package:notify2/pages/chat_screen.dart';
import 'package:notify2/services/local_notification.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  // bool multiple = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
        LocalNotification.initialize(flutterLocalNotificationsPlugin);
    initPlatformState();
    super.initState();
  }
  static void _callback(NotificationEvent evt) {
    // HANDLING BACKGROUND NOTIFICATIONS :
    print('GETTING INFO ');
    print(evt.packageName); // PACKAGE USE TO SEND MESSAGE :
    print(evt.text); // MESSAGE CONTENT  :
    print(evt.title);

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
            print('alert');
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


  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 20, right: 20),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 12.0,
                              childAspectRatio: 1.5,
                            ),
                            children: List<Widget>.generate(
                              homeList.length,
                              (int index) {
                                final int count = homeList.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );
                                animationController?.forward();
                                return HomeListView(
                                  animation: animation,
                                  animationController: animationController,
                                  listData: homeList[index],
                                  callBack: () {
                                    Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            homeList[index].navigateScreen!,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SizedBox(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Notify.AI',
                  style: TextStyle(
                    letterSpacing: 8,
                    fontSize: 22,
                    color: AppTheme.nearlyBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppBar().preferredSize.height,
            width: AppBar().preferredSize.height - 8,
          )
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Container(
                      height: 170,
                      width: 280,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 234, 176, 242)),
                      child: const Padding(
                        padding:  EdgeInsets.only(
                          bottom: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.cover,
                        height: 110,
                      ),
                    ),
                  ]),
                ),
                Positioned(
                  top: 50,
                  child: Text(
                    listData!.name,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: callBack,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
