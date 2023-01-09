import 'package:boratok/constants.dart';
import 'package:boratok/views/widgets/custom_icon.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        backgroundColor: backgroundColor,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30,), label: "Search"),
          BottomNavigationBarItem(icon: CustomIcon(), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message, size: 30,), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.add, size: 30,), label: "Profile"),


        ],
      ),
      body: Center(
        child: pages[pageIndex],
      ),
    );
  }
}
