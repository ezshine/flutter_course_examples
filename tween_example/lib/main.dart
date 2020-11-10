import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';
import 'dart:math'; 

void main() {
  runApp(MyHeart());
}


class MyHeart extends StatelessWidget
{
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
      ),
      home: MyHeartPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHeartPage extends StatefulWidget {
  MyHeartPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHeartState createState() => _MyHeartState();
}

class _MyHeartState extends State<MyHeartPage> with TickerProviderStateMixin
{
  AnimationController controller;
  Animation<Rect> animationRect;

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

    var nextTop = rng.nextDouble()*(s.height-100);
    var nextLeft = rng.nextDouble()*(s.width-100);

    controller = new AnimationController(
      duration: const Duration(milliseconds: 400), 
      vsync: this
    );
    animationRect = RectTween(begin: Rect.fromLTWH(btnLeft,btnTop,100,100),end: Rect.fromLTWH(nextLeft,nextTop,100,100)).animate(controller);
    animationRect.addListener((){
      setState((){});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:[
          Positioned(
            key: _key1,
            left: animationRect?.value?.left,
            top: animationRect?.value?.top,
            child:FlatButton(
                onPressed:(){
                  moveToNext();
                }, 
                child: AnimatedHeart()
              )
          )
        ],
      ),
    );
  }
}

class AnimatedHeart extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State  with TickerProviderStateMixin 
{
  AnimationController controller;
  Animation<Size> animationSize;

  startAnimation(){
    controller = new AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this
    );
    animationSize = SizeTween(begin: Size(100,100),end: Size(120,120)).animate(controller);
    animationSize.addListener((){
      setState((){
        // print(animationSize?.value);
      });
    });
    animationSize.addStatusListener((status) {
      if(status == AnimationStatus.completed){
          controller.reverse();
        }else if(status == AnimationStatus.dismissed){
          controller.forward();
        }
    });
    controller.forward();
  }

  @override
  void initState() {
    super.initState();

    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              width: animationSize?.value?.width,
              height: animationSize?.value?.height,
              decoration: BoxDecoration(
                color:Colors.transparent,
                image:DecorationImage(
                  image:AssetImage("images/xin.png"),
                  fit:BoxFit.fill
                )
              ),
              alignment: Alignment.center,
              child: null,
            );
  }
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
  
  AnimationController controller;
  Animation<int> animationInt;
  Animation<int> animationStep;
  Animation<Color> animationColor;
  Animation<Size> animationSize;
  Animation<Rect> animationRect;
  Animation<int> animationConstant;

  testIntTween(){
    controller = new AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this
    );
    animationInt=IntTween(begin: 0,end: 200).animate(controller);
    animationInt.addListener((){
      setState((){
        print(animationInt?.value);
      });
    });
    controller.forward();
  }

  testStepTween(){
    controller = new AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this
    );
    animationStep=StepTween(begin: 0,end: 200).animate(controller);
    animationStep.addListener((){
      setState((){
        print(animationStep?.value);
      });
    });
    controller.forward();
  }

  testColorTween(){
    controller = new AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this
    );
    animationColor = ColorTween(begin: Colors.black,end: Colors.red).animate(controller);
    animationColor.addListener((){
      setState((){
        print(animationColor?.value);
      });
    });
    controller.forward();
  }

  testSizeTween(){
    controller = new AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this
    );
    animationSize = SizeTween(begin: Size(100,100),end: Size(200,200)).animate(controller);
    animationSize.addListener((){
      setState((){
        print(animationSize?.value);
      });
    });
    controller.forward();
  }

  testRectTween(){
    controller = new AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this
    );
    animationRect = RectTween(begin: Rect.fromLTWH(0,0,100,100),end: Rect.fromLTWH(100,100,100,100)).animate(controller);
    animationRect.addListener((){
      setState((){
        print(animationRect?.value);
      });
    });
    controller.forward();
  }

  testConstantTween(){
    controller = new AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this
    );
    animationConstant = ConstantTween<int>(5).animate(controller);
    animationConstant.addListener((){
      setState((){
        print(animationConstant?.value);
      });
    });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    testConstantTween();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned(
            top:100,
            left:100,
            width: animationSize?.value?.width,
            height: animationSize?.value?.height,
            child: Container(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
