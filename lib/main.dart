import 'package:flutter/material.dart';
import 'package:frozendriverapp/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    MyApp(
      child:MaterialApp(
        title: 'Frozen2Go Captains',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const MySplashScreen(),
        debugShowCheckedModeBanner: false,
      )
    )
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;
  MyApp({this.child});

  static void Restartapp(BuildContext context){

    context.findAncestorStateOfType<_MyAppState>()!.Restartapp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Key key= UniqueKey();
  void Restartapp(){
    setState(() {
      UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
        key: key,
        child: widget.child!
    );
  }
}


