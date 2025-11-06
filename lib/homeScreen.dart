import 'package:flutter/material.dart';
import 'package:vitalvaultbeta/components/appBody.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Appbody(child: Column(children: [
          
        ],
      )),
    );
  }
}
