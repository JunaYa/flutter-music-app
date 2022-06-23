
import 'dart:async';

import 'package:app/pages/extentions.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


const Color _gredientBgColor1 = Color.fromARGB(255, 24, 25, 28);
const Color _gredientBgColor2 = Color.fromARGB(255, 56, 58, 64);
const Color _gredientColor1 = Color.fromARGB(255, 42, 41, 45);
const Color _gredientColor2 = Color.fromRGBO(22, 17, 22, 1);



class AlbumBoard extends StatefulWidget {
  final AudioPlayer player;
  const AlbumBoard({Key? key, required this.player}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => AlbumBoardState();
  
}

class AlbumBoardState extends State<AlbumBoard> with TickerProviderStateMixin {
  double turns = 0.0;
  PlayerState _playerState = PlayerState.stopped;

  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  AudioPlayer get player => widget.player;

  bool get _isPlaying => _playerState == PlayerState.playing;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 80), vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    _initStreams();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

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
        child: GestureDetector(
          child: RotationTransition(
            turns: _animation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset('assets/images/album.jpg', fit: BoxFit.cover,),
            ),
          ),
        ),
      ).addNeumorphism(
        blurRadius: 16,
        borderRadius: 100,
        offset: const Offset(14, 14),
        topShadowColor: const Color.fromARGB(255, 60, 66, 73),
        bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
    );
  }

  void _initStreams() {
    _positionSubscription = player.onPositionChanged.listen((p) {
      // _controller.repeat();
    });

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      player.stop();
      setState(() {
        _playerState = PlayerState.stopped;
      });
      _controller.stop();
    });

    _playerStateChangeSubscription = player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
      if (state == PlayerState.playing) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

}


