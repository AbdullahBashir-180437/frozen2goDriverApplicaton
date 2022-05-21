import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frozendriverapp/Global/global.dart';
import 'package:frozendriverapp/authenication/login_screen.dart';
import 'package:frozendriverapp/authenication/truckinfo_screen.dart';
import 'package:frozendriverapp/widget/progress_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
{
  TextEditingController nametextEditingController =TextEditingController();
  TextEditingController EmailtextEditingController =TextEditingController();
  TextEditingController PhonetextEditingController =TextEditingController();
  TextEditingController passwordtextEditingController =TextEditingController();

  validateForm()
  {
    if(nametextEditingController.text.length<3){
      Fluttertoast.showToast(msg: "Name should be atleast 3 Characters");
    }
    else if(!EmailtextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg: "Invalid Email ID");
    }
    else if(PhonetextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Phone Number is Required");
    }
    else if(passwordtextEditingController.text.length <5){
      Fluttertoast.showToast(msg: "Password Must be 5 characters long");
    }
    else
      {
        saveDriverInfoNow();
      }
  }
  saveDriverInfoNow() async
  {
    showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing , please Wait",);
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
          email:EmailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error:  " + msg.toString());
        })
    ).user ;

    if(firebaseUser != null)
      {
        Map driverMap={
          "id":firebaseUser.uid,
          "name":nametextEditingController.text.trim(),
          "email":EmailtextEditingController.text.trim(),
          "password":passwordtextEditingController.text.trim(),

        };

        DatabaseReference driverref =FirebaseDatabase.instance.ref().child("Drivers");
        driverref.child(firebaseUser.uid).set(driverMap);

        currentFirebaseUser =firebaseUser;
        Fluttertoast.showToast(msg: "Account creation successful");
        Navigator.push(context, MaterialPageRoute(builder: (c)=>TruckinfoScreen()));
      }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account creation unsuccessful");

      }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              const SizedBox(height:  15,),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.asset("images/logo1.jpg"),
              ),
              const SizedBox(height: 5,),

              const Text(" Register  As  Driver ",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                  fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 20,),
              TextField(
                controller: nametextEditingController,
                keyboardType: TextInputType.emailAddress,
                style:const  TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: " Enter your Name Here",
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
              ),  //name
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
                controller: PhonetextEditingController,
                keyboardType: TextInputType.phone,
                style:const  TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: " Enter your Mobile Number Here ",
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
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                child: const Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(color:Colors.white),

                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
              )
            ],
          ),
        ),
      )
    );
  }
}
