import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rt/login.dart';

class Welcome extends StatefulWidget {
  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 193, 188, 231),
      body: Column(
        children: [
          Center(
            child: Hero(
                tag: "logo",
                child: Image.asset('images/IMG_٢٠٢٥٠٤٢٣_٢١٠٤١٤.jpg')),
          ),
          SizedBox(
            height: 10,
          ),
          Center(child: Image.asset('images/IMG_٢٠٢٥٠٤٢٣_٠٧٤٧٤٧.jpg'))
        ],
      ),
    );
  }
}
