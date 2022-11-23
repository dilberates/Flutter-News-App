import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: MotionTabBarView(

      ),
    );
  }
}
