import 'package:flutter/material.dart';
import 'package:frozendriverapp/Global/global.dart';
import 'package:frozendriverapp/splashScreen/splash_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(
          "Signout"
        ),
        onPressed: ()
        {
          fAuth.signOut();
          Navigator.push(context,MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        },
      )
    );
  }
}
