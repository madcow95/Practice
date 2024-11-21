import 'package:contact/screen/home_screen.dart';
import 'package:contact/widget/bottom_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MadCow',
      theme: ThemeData(
          colorScheme: ColorScheme.dark(
            secondary: Colors.white
          ),
      ),
      // NeverScrollableScrollPhysics: 손가락 움직임으로 탭을 변경하지 않는다
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                Center(
                  child: Text('search'),
                ),
                Center(
                  child: Text('save'),
                ),
                Center(
                  child: Text('list'),
                ),
              ],
            ),
            bottomNavigationBar: Bottom(),
          )
      ),
    );
  }
}