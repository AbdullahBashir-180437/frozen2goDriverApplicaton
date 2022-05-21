import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frozendriverapp/widget/brand_colors.dart';

class Confirmsheet extends StatelessWidget {

  final String title;
  final String subtitle;
  final VoidCallback onPressed;


  const Confirmsheet({required this.title,required this.subtitle,required this.onPressed});




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Colors.white,
        boxShadow: [
          BoxShadow()
        ]

      ),
      height: 200,
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24 ,vertical:18),
        child: Column(
          children:<Widget>[

            SizedBox(height:10,),

            Text(
              title,
              textAlign: TextAlign.center,
              style:TextStyle(fontSize: 22,fontFamily: 'Brand-Bold')
            ),
            SizedBox(height: 20,),

            Text(
              subtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24,),
          Positioned(
          top:30,
          left: 0,
          right:0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
            ElevatedButton(
              child: Text("Back"
                        ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
                  onPrimary: Colors.red, // foreground
                ),
              onPressed: ()
              {
                Navigator.pop(context);
              }
      ),
                  SizedBox(width:80),
                  ElevatedButton(
                      child: Text("confirm"
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen, // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: onPressed,
                  ),
      ]
    )
    )
    ]
      )
      )
    );
  }
}
