import 'package:flutter/material.dart';
import 'mainscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Material App',
      home: Scaffold(
          body: Container(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 2000,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/image.png',
                  width: 300, height: 300, fit: BoxFit.fill),
                  
            ),
            
            Container(child: ProgressIndicator())
          ],
        ),
      )),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      width: 200,
      child: LinearProgressIndicator(
        value: animation.value,
        backgroundColor: Colors.grey,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple[400]),
      ),
    ));
  }
}
