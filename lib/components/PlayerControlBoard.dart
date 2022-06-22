
import 'dart:async';

import 'package:app/pages/extentions.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


const Color _gredientBgColor1 = Color.fromARGB(255, 24, 25, 28);
const Color _gredientBgColor2 = Color.fromARGB(255, 56, 58, 64);
const Color _gredientColor1 = Color.fromARGB(255, 42, 41, 45);
const Color _gredientColor2 = Color.fromRGBO(22, 17, 22, 1);

class PlayerControlBoard extends StatefulWidget {
  final AudioPlayer player;
  final String url;
  const PlayerControlBoard({Key? key, required this.player, required this.url}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PlayerControlBoardState();
  }
}

class _PlayerControlBoardState extends State<PlayerControlBoard> {
  AudioPlayer get player => widget.player;
  
  PlayerState _playerState = PlayerState.playing;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  @override
  void initState() {
    _init();
    super.initState();
    _initStreams();
  }

  @override
  void dispose() {
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

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
              if (!_isPlaying) {
                _resume();
              } else {
                _pause();
              }
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
              child: _isPlaying 
                ? const Icon(
                  Icons.pause,
                  color: Colors.white,
                  size: 32.0)
                : const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32.0),
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

  void _initStreams() {
    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      print('state');
      player.stop();
      setState(() {
        _playerState = PlayerState.stopped;
      });
    });

    _playerStateChangeSubscription = player.onPlayerStateChanged.listen((state) {
      print('state $state');
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _init() async {
    await player.setSource(UrlSource(widget.url));
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _resume() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() => _playerState = PlayerState.stopped);
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
          tileMode: TileMode.clamp,
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
