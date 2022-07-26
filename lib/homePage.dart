import 'dart:async';
import 'package:flappy_bird/barriers.dart';
import 'package:flutter/material.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void StartGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      setState(() {
        if(barrierXone<-2){
          barrierXone += 3;
        }
        else{
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if(barrierXtwo<-2){
          barrierXtwo += 3;
        }
        else{
          barrierXtwo -= 0.05;
        }
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
                    if (gameHasStarted) {
                      jump();
                    } else {
                      StartGame();
                    }
                  },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: FlyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text("")
                        : Text("TAP TO PLAY",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 6,
                                color: Colors.white)),
                  ),
                AnimatedContainer(
                  alignment: Alignment(barrierXone,1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 150,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXone,-1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 120,
                  )),
    
                  // Second Barrier
    
                  AnimatedContainer(
                  alignment: Alignment(barrierXtwo,1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 100,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXtwo,-1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 140,
                  )),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SCORE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "BEST",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
