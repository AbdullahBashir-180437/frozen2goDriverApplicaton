import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frozendriverapp/Global/global.dart';
import 'package:flutter/material.dart';
import 'package:frozendriverapp/widget/ConfirmSheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../widget/brand_colors.dart';


class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}


class _HomeTabPageState extends State<HomeTabPage> {
  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  late GoogleMapController mapController;
  Completer<GoogleMapController>_controller = Completer();

  late Position currentPosition;

  var geolocator=Geolocator();
  var locationOptions = LocationSettings(accuracy: LocationAccuracy.bestForNavigation,distanceFilter: 4);


  late DatabaseReference orderRequestRef;

  String availabilityTitle = 'Ready to Receive Orders';
  Color availabilitycolor = Colors.blue;

  bool isAvailable = false;



    void getCurrentPosition() async{
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;


    LatLng pos =LatLng(position.latitude,position.longitude);
    CameraPosition cp=new CameraPosition(target: pos,zoom:14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          padding: const EdgeInsets.only(top: 150),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,

          mapType: MapType.normal,
          initialCameraPosition: _kLake,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
            mapController = controller;

            getCurrentPosition();


          },
        ),


        Positioned(
          top:40,
          left: 0,
          right:0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(availabilityTitle ),
                style: ElevatedButton.styleFrom(
                  primary: availabilitycolor, // background
                  onPrimary: Colors.red, // foreground
                ),
                onPressed: ()
                {
                  Fluttertoast.showToast(
                      msg: 'Good Luck.Have a Nice Day!');


                  showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (BuildContext context) => Confirmsheet(
                        title: (!isAvailable)? 'Ready to Receive Order':'Tired! Want to Take a break',
                        subtitle:(!isAvailable)? 'Getting You Online Caption.':'Getting You Offline Caption',
                          onPressed:(){

                          if(!isAvailable){
                            GoOnline();
                            getlocationupdates();
                            Navigator.pop(context);


                                setState(() {
                                  availabilitycolor= Colors.green;
                                  availabilityTitle='Tired! Want to Take a break';
                                  isAvailable=true;
                                });
                          }
                          else{
                            goofline();
                            Navigator.pop(context);
                            setState(() {
                              availabilitycolor= Colors.blue;
                              availabilityTitle='Ready to Receive Order';
                              isAvailable=false;
                            });
                          }

                },

                      ),
                  );
                  },
              )
            ],
          ),
        )
      ],
    );
  }

  void GoOnline(){
      Geofire.initialize('driversavailable');
      Geofire.setLocation(currentFirebaseUser!.uid, currentPosition.latitude, currentPosition.longitude);

      orderRequestRef = FirebaseDatabase.instance.ref().child('Drivers/${currentFirebaseUser!.uid}/neworder');
      orderRequestRef.set('Waiting');
      orderRequestRef.onValue.listen((event) {

      });
  }
  void getlocationupdates(){

        StreamSubscription<Position> homeTabPositionStream;
        homeTabPositionStream = Geolocator.getPositionStream(locationSettings: locationOptions).listen((Position position){
        currentPosition=position;

        if(isAvailable){
          Geofire.setLocation(currentFirebaseUser!.uid, position.latitude, position.longitude);

        }


        LatLng pos =LatLng(position.latitude,position.longitude);
        mapController.animateCamera(CameraUpdate.newLatLng(pos));


      });
  }


  void goofline() {
    Geofire.removeLocation(currentFirebaseUser!.uid);
    orderRequestRef.onDisconnect();
    orderRequestRef.remove();

  }

}
