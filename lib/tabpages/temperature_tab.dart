import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/brand_colors.dart';

class TemperatureTabPage extends StatefulWidget {
  const TemperatureTabPage({Key? key}) : super(key: key);

  @override
  State<TemperatureTabPage> createState() => _TemperatureTabPageState();
}
_launchURLApp() async {
  const url = 'http://192.168.0.59/';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
class _TemperatureTabPageState extends State<TemperatureTabPage> {
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
                  'Temperature and Humidity Section',
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
                  'Click Below to Get Realtime Updates',
                  style: TextStyle(
                    fontSize: 15.0,
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
