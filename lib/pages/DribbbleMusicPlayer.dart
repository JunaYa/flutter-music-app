import 'package:app/pages/extentions.dart';
import 'package:flutter/material.dart';
import '../components/Neumorphism.dart';

class DribbbleMusicPlayer extends StatelessWidget {
  const DribbbleMusicPlayer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: size.height,
          color: const Color.fromARGB(255, 52, 58, 63),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color.fromARGB(255, 44, 48, 53),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Color.fromARGB(255, 42, 41, 45),
                            Color.fromARGB(255, 22, 17, 22),
                          ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                    ).addNeumorphism(
                      blurRadius: 10,
                      borderRadius: 30,
                      offset: const Offset(5, 5),
                      topShadowColor: const Color.fromARGB(255, 60, 66, 73),
                      bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
                    ),
                    Text('play now'.toUpperCase(), style: const TextStyle(color: Colors.white),),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color.fromARGB(255, 44, 48, 53),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Color.fromARGB(255, 42, 41, 45),
                            Color.fromARGB(255, 22, 17, 22),
                          ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: const Icon(
                        Icons.list,
                        color: Colors.white,
                        size: 24.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                    ).addNeumorphism(
                      blurRadius: 10,
                      borderRadius: 30,
                      offset: const Offset(5, 5),
                      topShadowColor: const Color.fromARGB(255, 60, 66, 73),
                      bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}