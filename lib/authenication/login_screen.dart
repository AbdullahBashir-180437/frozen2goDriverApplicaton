import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frozendriverapp/authenication/signup_screen.dart';
import 'package:frozendriverapp/splashScreen/splash_screen.dart';

import '../Global/global.dart';
import '../widget/progress_dialog.dart';

class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController EmailtextEditingController =TextEditingController();
  TextEditingController passwordtextEditingController =TextEditingController();
  validateForm()
  {
    if(!EmailtextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg: "Invalid Email ID");
    }
    else if(passwordtextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Password Cannot be Empty");
    }
    else
    {
      loginDriverNow();
    }
  }
  loginDriverNow() async
    {
    showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Verifying  , please Wait",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email:EmailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error:  " + msg.toString());
        })
    ).user ;

    if(firebaseUser != null)
    {
      currentFirebaseUser =firebaseUser;
      Fluttertoast.showToast(msg: "Login successful");
      Navigator.push(context, MaterialPageRoute(builder: (c)=>const MySplashScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Login unsuccessful due to Error");

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
          children: [
            const SizedBox(height:  15,),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset("images/logo1.jpg"),
            ),
            const SizedBox(height: 30,),

            const Text(" Login  As  Driver ",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            TextField(
              controller: EmailtextEditingController,
              keyboardType: TextInputType.emailAddress,
              style:const  TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: "Email ID",
                hintText: " Enter your Email Here ",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.black)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.black)
                ),
                hintStyle: TextStyle(
                  color:Colors.white,
                  fontSize: 20,
                ),
                labelStyle: TextStyle(
                  color:Colors.black,
                  fontSize:20,
                ),
              ),
            ),
            TextField(
              controller: passwordtextEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style:const  TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: " Enter your Password Here ",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.black)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.black)
                ),
                hintStyle: TextStyle(
                  color:Colors.white,
                  fontSize: 20,
                ),
                labelStyle: TextStyle(
                  color:Colors.black,
                  fontSize:20,
                ),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                validateForm();
              },
              style:ElevatedButton.styleFrom(
                  primary:Colors.white
              ),
              child: const Text(
                "Login Account",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30,),
            TextButton(
              child: const Text(
                "Donot Have Account ? Create Account Here!",
                style: TextStyle(color:Colors.white),

              ),
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> SignupScreen()));
              },
            )
          ],
          ),
        ),

      )
    );
  }
}
