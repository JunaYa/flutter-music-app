import 'dart:async';
import 'dart:math';

import 'package:app/pages/extentions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const Color _gredientBgColor1 = Color.fromARGB(255, 24, 25, 28);
const Color _gredientBgColor2 = Color.fromARGB(255, 56, 58, 64);
const Color _gredientColor1 = Color.fromARGB(255, 42, 41, 45);
const Color _gredientColor2 = Color.fromRGBO(22, 17, 22, 1);

class DribbbleMusicPlayer extends StatelessWidget {
  const DribbbleMusicPlayer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: size.height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color.fromARGB(255, 44, 48, 53),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                _gredientBgColor2,
                _gredientBgColor1,
              ], // Gradient from https://learnui.design/tools/gradient-generator.html
              tileMode: TileMode.mirror,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(padding: EdgeInsets.all(6)),
              HeaderBoard(),
              Padding(padding: EdgeInsets.all(10)),
              AlbumBoard(),
              Padding(padding: EdgeInsets.all(36)),
              Text('Low life',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )),
              Padding(padding: EdgeInsets.all(4)),
              Text('FM.Hometown 赶路人',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white
                )
              ),
              PlayerProgressBoard(),
              PlayerControlBoard(),
            ],
          ),
      ),
    );
  }
}

class HeaderBoard extends StatelessWidget {
  const HeaderBoard({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  _gredientColor1,
                  _gredientColor2,
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
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Color.fromARGB(255, 44, 48, 53),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    _gredientColor1,
                    _gredientColor2,
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
          )
        ],
      ),
    );
  }
}

class AlbumBoard extends StatelessWidget {
  const AlbumBoard({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
        border: Border.all(color: Colors.black, width: 8),
        color: const Color.fromARGB(255, 44, 48, 53),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            _gredientColor1,
            _gredientColor2,
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.asset('assets/images/album.jpg', fit: BoxFit.cover,),
      ),
    ).addNeumorphism(
      blurRadius: 16,
      borderRadius: 100,
      offset: const Offset(14, 14),
      topShadowColor: const Color.fromARGB(255, 60, 66, 73),
      bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
    );
  }
}

class PlayerProgressBoard extends StatefulWidget {
  const PlayerProgressBoard({Key? key}) : super(key: key);
  
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
                      //打印手指按下的位置(屏幕)
                      print("用户手指按下：${e.globalPosition}");
                    },
                    //手指滑动时会触发此回调
                    onPanUpdate: (DragUpdateDetails e) {
                      //用户手指滑动时，更新偏移，重新构建
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
                      //打印滑动结束时在x、y轴上的速度
                      print(e.velocity);
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
}

class PlayerControlBoard extends StatefulWidget {
  const PlayerControlBoard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayerControlBoardState();
  }
}

class _PlayerControlBoardState extends State<PlayerControlBoard> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ButtonPlay(
            icon: Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            )
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isPlaying = !isPlaying;
              });
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Color.fromARGB(255, 44, 48, 53),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    _gredientColor1,
                    _gredientColor2,
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
              ),
              child: isPlaying 
                ? const Icon(
                  Icons.pause,
                  color: Colors.white,
                  size: 24.0)
                : const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24.0),
            ).addNeumorphism(
              blurRadius: 10,
              borderRadius: 40,
              offset: const Offset(5, 5),
              topShadowColor: const Color.fromARGB(255, 60, 66, 73),
              bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
            ),
          ),
          const ButtonPlay(
            icon: Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            )
          ),
        ],
      )
    );
  }

}

class ButtonPlay extends StatelessWidget {
  final Widget icon;
  const ButtonPlay({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(28.0)),
        color: Color.fromARGB(255, 44, 48, 53),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            _gredientColor1,
            _gredientColor2,
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      child: icon,
    ).addNeumorphism(
      blurRadius: 10,
      borderRadius: 28,
      offset: const Offset(5, 5),
      topShadowColor: const Color.fromARGB(255, 60, 66, 73),
      bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
    );
  }

}