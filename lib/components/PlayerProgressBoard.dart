
import 'package:app/pages/extentions.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const Color _gredientBgColor1 = Color.fromARGB(255, 24, 25, 28);
const Color _gredientBgColor2 = Color.fromARGB(255, 56, 58, 64);
const Color _gredientColor1 = Color.fromARGB(255, 42, 41, 45);
const Color _gredientColor2 = Color.fromRGBO(22, 17, 22, 1);

class PlayerProgressBoard extends StatefulWidget {
  final AudioPlayer player;

  const PlayerProgressBoard({Key? key, required this.player}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _PlayerProgressBoard();

}

class _PlayerProgressBoard extends State<PlayerProgressBoard> {
  double position = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double maxPosition = size.width - 48 - 28;
    return Container(
      margin: const EdgeInsets.only(top: 48, bottom: 68),
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('00:00', style: TextStyle(color: Colors.white, fontSize: 14),),
              Text('01:00', style: TextStyle(color: Colors.white, fontSize: 14),),
            ],
          ),
          const Padding(padding: EdgeInsets.all(8)),
          SizedBox(
            width: double.infinity,
            height: 6,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 6,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        _gredientColor2,
                        Color.fromARGB(255, 89, 88, 93),
                      ], // Gradient from https://learnui.design/tools/gradient-generator.html
                      tileMode: TileMode.mirror,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 0,
                  right: maxPosition - position,
                  child: Container(
                    width: double.infinity,
                    height: 4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Color.fromARGB(255, 186, 70, 20),
                          Color.fromARGB(255, 238, 229, 97),
                        ], // Gradient from https://learnui.design/tools/gradient-generator.html
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: Container(
                      width: 19,
                      // color: const Color.fromARGB(255, 202, 84, 33),
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  left: position,
                  child: GestureDetector(
                    onPanDown: (DragDownDetails e) {
                      print("onPanDown ${e}");
                      _seek(position);
                    },
                    onPanUpdate: (DragUpdateDetails e) {
                      print("onPanUpdate ${e}");
                      setState(() {
                        double temp = position + e.delta.dx;
                        if (temp <= 0) {
                          position = 0;
                        } else if (temp > maxPosition) {
                          position = maxPosition;
                        } else {
                          position = temp;
                        }
                      });
                    },
                    onPanEnd: (DragEndDetails e) {
                      print("onPanEnd ${e}");
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                        color: const Color.fromARGB(255, 238, 229, 97),
                        border: Border.all(color: _gredientColor2, width: 10),
                      ),
                    ).addNeumorphism(
                      blurRadius: 10,
                      borderRadius: 18,
                      offset: const Offset(5, 5),
                      topShadowColor: const Color.fromARGB(255, 60, 66, 73),
                      bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
                    ),
                  ),
                ),
              ],
            )
          )
        ],
      )
    );
  }

   Future<void> _seek(position) async {
    await widget.player.seek(position);
  }
}
