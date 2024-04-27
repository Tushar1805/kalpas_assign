import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => {});
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Center(
        child: Image.asset("assets/favs.png"),
      ),
    );
  }
}
