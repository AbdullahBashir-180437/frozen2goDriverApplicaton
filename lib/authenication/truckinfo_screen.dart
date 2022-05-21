import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frozendriverapp/Global/global.dart';
import 'package:frozendriverapp/splashScreen/splash_screen.dart';

class TruckinfoScreen extends StatefulWidget {


  @override
  State<TruckinfoScreen> createState() => _TruckinfoScreenState();
}

class _TruckinfoScreenState extends State<TruckinfoScreen> {
  TextEditingController truckmodeltextEditingController =TextEditingController();
  TextEditingController trucknumbertextEditingController =TextEditingController();
  TextEditingController truckcolortextEditingController =TextEditingController();

  List<String> truckTypeList = ["Refrigerated Truck","Cold Truck","Isothermal Truck"];
  String? selectedtrucktype;


  Savetruckinfo()
  {
      Map drivertruckinfoMap=
      {
        "truckcolor": truckcolortextEditingController.text.trim(),
        "trucknumber": trucknumbertextEditingController.text.trim(),
        "truckmodel": truckmodeltextEditingController.text.trim(),
        "type": selectedtrucktype,

      };
      DatabaseReference driverref =FirebaseDatabase.instance.ref().child("Drivers");
      driverref.child(currentFirebaseUser!.uid).child("Truck_Details").set(drivertruckinfoMap);

      Fluttertoast.showToast(msg: "Truck Details Added Successfully. Congratulations on Becoming Captain of Frozen2Go");
      Navigator.push(context, MaterialPageRoute(builder: (c)=>const MySplashScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height:  15,),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.asset("images/trucklogo.jpg"),
              ),
              const SizedBox(height: 5,),

              const Text(" Register  Your  Truck ",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              const SizedBox(height: 30,),
              TextField(
                controller: truckmodeltextEditingController,
                keyboardType: TextInputType.emailAddress,
                style:const  TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Truck Model",
                  hintText: " Enter your Truck Model Here  ",
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
                controller: trucknumbertextEditingController,
                style:const  TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Truck Number",
                  hintText: " Enter your Truck Number Here ",
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
                controller: truckcolortextEditingController,
                style:const  TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Truck Color",
                  hintText: " Enter your Truck Color Here ",
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

              const SizedBox(height:  25,),
              DropdownButton(
              iconSize: 26,
              hint: Text(
                "Choose your Truck Type",
              style:const  TextStyle(
                fontSize: 14.0,
                color:Colors.black,
              ),
            ),
              value:selectedtrucktype,
              onChanged: (newValue){
                setState(() {
                  selectedtrucktype=newValue.toString();
                });
              },
              items:truckTypeList.map((truck){
                return DropdownMenuItem(
                  child:Text(
                    truck,
                    style:const TextStyle(color:Colors.black),
                  ),
                  value:truck,
                );
              }).toList(),
            ),

              const SizedBox(height:  40,),
              ElevatedButton(
                onPressed: () {
                  if(truckcolortextEditingController.text.isNotEmpty &&
                      truckmodeltextEditingController.text.isNotEmpty
                      && trucknumbertextEditingController.text.isNotEmpty
                  && selectedtrucktype !=null)
                    {
                      Savetruckinfo();
                    }

                },
                style:ElevatedButton.styleFrom(
                    primary:Colors.white
                ),
                child: const Text(
                  "Register Truck",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
