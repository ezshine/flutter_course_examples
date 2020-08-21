import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';
import 'dart:math'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<Rect> animation;
  AnimationController controller;
  GlobalKey _key1 = GlobalKey();

  var s = window.physicalSize/window.devicePixelRatio;
  var rng = new Random();

  double btnTop=0;
  double btnLeft=0;

  moveToNext(){
    RenderBox box = _key1.currentContext.findRenderObject();
    if(box!=null){
      Offset offset = box.localToGlobal(Offset.zero);
      btnTop=offset.dy;
      btnLeft=offset.dx;
    }

    var nextTop = rng.nextDouble()*(s.height-40);
    var nextLeft = rng.nextDouble()*(s.width-100);

    controller = new AnimationController(
          duration: const Duration(milliseconds: 400), 
          vsync: this
          );
      animation = RectTween(begin: Rect.fromLTRB(btnLeft,btnTop,100,100),end: Rect.fromLTRB(nextLeft,nextTop,100,100)).animate(controller);
      animation.addListener((){
        setState((){});
      });
      controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child:Stack(
        children: [
          Positioned(
            key: _key1,
            top: animation?.value?.top,
            left: animation?.value?.left,
            width: 100,
            height: 40,
            child: RaisedButton(
              onPressed: (){
                moveToNext();
              },
              color: Colors.red,
              child:Text(
                'click me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
                )
              )
            )
          )
        ]
      )
    );
  }
}
