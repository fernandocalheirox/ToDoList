import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todo_list/pages/list_page.dart';

class LoadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SplashScreen(
        backgroundColor: Color(0xFF232729),
        seconds: 5,
        navigateAfterSeconds: ListPage(),
        image: Image.asset("assets/logo.png"),
        loaderColor: Color(0xFF6BADE4),
        photoSize: 170,
      ),
    );
  }
}
