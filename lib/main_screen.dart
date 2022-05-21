import 'package:flutter/material.dart';
import 'package:frozendriverapp/tabpages/temperature_tab.dart';
import 'package:frozendriverapp/tabpages/home_tab.dart';
import 'package:frozendriverapp/tabpages/profile_tab.dart';
import 'package:frozendriverapp/tabpages/drowsiness_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  with SingleTickerProviderStateMixin{
  TabController ?tabController;
  int selectedIndex = 0;

  onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController!.index=selectedIndex;

    });
  }

  @override
  void initState() {
        super.initState();

        tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: TabBarView(
       physics:const NeverScrollableScrollPhysics(),
       controller: tabController,
       children: const [
         HomeTabPage(),
         TemperatureTabPage(),
         drwosinessTabPage(),
         ProfileTabPage(),


       ],
     ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),label: "Temperature"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),label: "Drowsiiness"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),label: "Account"),
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.lightBlue,
        type:BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 13),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),

    );
  }
}
