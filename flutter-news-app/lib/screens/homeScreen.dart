import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/favoriteNewsScreen.dart';
import 'package:flutter_news_app/screens/newsScreen.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _screens = [NewsScreen(), FavoriteNewsScreen()];
  late MotionTabController _controller;

  @override
  void initState() {
    _controller = MotionTabController(vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
        ],
      ),
      body: MotionTabBarView(
        controller: _controller,
        children: _screens,
      ),
      bottomNavigationBar: MotionTabBar(
        labels: ["News","Favorite"],
        initialSelectedTab: "News",
        tabIconColor: Colors.indigo,
        tabSelectedColor: Colors.lightBlue,
        icons: [Icons.newspaper_outlined,Icons.favorite_border],
        textStyle: TextStyle(color:Colors.black),
        onTabItemSelected: (int value){
          setState(() {
            _controller.index=value;
          });
        },
      ),
    );
  }
}
