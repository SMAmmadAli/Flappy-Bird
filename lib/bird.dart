import 'package:flutter/material.dart';

class FlyBird extends StatelessWidget {
  const FlyBird({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Image.asset("lib/images/fly Bird.png")      
    );
  }
}