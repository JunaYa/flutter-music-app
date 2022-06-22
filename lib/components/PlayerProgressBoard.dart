
import 'dart:async';

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
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  AudioPlayer get player => widget.player;
  String get _durationText => _duration?.toString().split('.').first ?? '00:00:00';
  String get _positionText => _position?.toString().split('.').first ?? '00:00:00';
  int get p => _position?.inMicroseconds ?? 0;
  int get d => _duration?.inMicroseconds ?? 0;
  double get rate => p / d;
  double position = 0;

  bool isSeeking = false;

  @override
  void initState() {
    super.initState();
    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

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
            children: [
              Text(_positionText, style: const TextStyle(color: Colors.white, fontSize: 14),),
              Text(_durationText, style: const TextStyle(color: Colors.white, fontSize: 14),),
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
                  right: maxPosition - (isSeeking ? position : maxPosition * rate),
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
                  ),
                ),
                Positioned(
                  top: -10,
                  left: isSeeking ? position : maxPosition * rate,
                  child: GestureDetector(
                    onPanDown: (DragDownDetails e) {
                      setState(() {
                        position = maxPosition * rate;
                        isSeeking = true;
                      });
                    },
                    onPanUpdate: (DragUpdateDetails e) {
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
                      setState(() {
                        isSeeking = false;
                      });
                      int sDuration = _duration?.inMicroseconds ?? 0;
                      int s = ((position / maxPosition) * sDuration).toInt();
                      _seek(Duration(microseconds: s));
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

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

  }
}
