import 'package:flutter/material.dart';
import 'package:notify2/model/homelist.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
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
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 224, 253),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.amber,
            // leading: Icon(Icons.menu),
            pinned: true,
            expandedHeight: 300,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 3,
              title: const Text("N O T I F Y"),
              centerTitle: true,
              background: Container(
                color: Colors.pink,
              ),
            ),
          ),
          // List.generate(
          //   homeList.length,
          //   (index) => Boxes(title: homeList[index].name,),

          // )
          SliverToBoxAdapter(
            child: Container(
                width: double.infinity,
                height: 900,
                color: Colors.amber,
                child: ListView.separated(
                    itemBuilder: (context, index) => Boxes(
                          title: homeList[index].name,
                        ),
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: homeList.length)),
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
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    child: Column(
                      children: [
                        Image.asset(
                          listData!.imagePath,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  Positioned.directional(
                      textDirection: TextDirection.rtl,
                      bottom: 0,
                      child: Text(
                        listData!.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      onTap: callBack,
                    ),
                  ),
                ],
              ),
            ),
            // ),
          ),
        );
      },
    );
  }
}

class Boxes extends StatelessWidget {
  Boxes({super.key, this.title = ''});

  String title;
  // Widget path;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(path),
      child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 150,
              color: Colors.deepPurple[300],
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(18.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ]),
              )),
            ),
          )),
    );
  }
}
