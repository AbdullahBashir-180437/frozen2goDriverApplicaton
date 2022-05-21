import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/brand_colors.dart';

class drwosinessTabPage extends StatefulWidget {
  const drwosinessTabPage({Key? key}) : super(key: key);

  @override
  State<drwosinessTabPage> createState() => _drwosinessTabPageState();
}
_launchURLApp() async {
  const url = 'http://192.168.0.75';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

class _drwosinessTabPageState extends State<drwosinessTabPage> {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 250.0,
                ),
                Text(
                  'Drowsiness Detection Section',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: BrandColors.colorDimText,
                    fontWeight: FontWeight.bold,

                  ),
                ),

                Container(
                  height: 25.0,
                ),
                Text(
                  'Click Below to Get Realtime Updates for Driver Drowsiness',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: BrandColors.colorDimText,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  height: 25.0,
                ),
                ElevatedButton(
                  onPressed: _launchURLApp,
                  child: Text('Get Updates'),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

