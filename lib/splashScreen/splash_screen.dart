import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frozendriverapp/Global/global.dart';
import 'package:frozendriverapp/authenication/login_screen.dart';
import 'package:frozendriverapp/authenication/signup_screen.dart';
import 'package:frozendriverapp/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

 startTimer()
 {
   Timer(const Duration(seconds : 3), ()async
   {
     if(await fAuth.currentUser !=null)
       { currentFirebaseUser = fAuth.currentUser;
         Navigator.push(context, MaterialPageRoute(builder: (c)=>MainScreen()));
       }
     else {
       Navigator.push(
           context, MaterialPageRoute(builder: (c) => LoginScreen()));
     }
         } );
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.jpg"),

            const SizedBox(height: 15,),

            const Text("Frozen2Go Captain Portal",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,

            ),)
          ],
        ),
      ),
    );
  }
}
