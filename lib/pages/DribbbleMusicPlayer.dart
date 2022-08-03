
import 'dart:io';

import 'package:app/components/AlbumBoard.dart';
import 'package:app/components/HeaderBoard.dart';
import 'package:app/components/PlayerControlBoard.dart';
import 'package:app/components/PlayerProgressBoard.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color _gredientBgColor1 = Color.fromARGB(255, 24, 25, 28);
const Color _gredientBgColor2 = Color.fromARGB(255, 56, 58, 64);
const Color _gredientColor1 = Color.fromARGB(255, 42, 41, 45);
const Color _gredientColor2 = Color.fromRGBO(22, 17, 22, 1);

class DribbbleMusicPlayer extends StatefulWidget {
  const DribbbleMusicPlayer({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _DribbbleMusicPlayer();
  
}

class _DribbbleMusicPlayer extends State<DribbbleMusicPlayer>{
  AudioPlayer player = AudioPlayer();
  String url  = 'https://r.hetao101.com/c/niq8uuoc2o.mp3';
  bool isDesktop = !kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    isDesktop ? const SizedBox(height: 16) : const SizedBox(height: 0),
                    const HeaderBoard(),
                    AlbumBoard(player: player),
                    const AspectRatio(aspectRatio: 20,
                      child: Text('Low life',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )
                      )
                    ),
                    const AspectRatio(aspectRatio: 16,
                      child: Text('FM.Hometown 赶路人',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white
                        )
                      )
                    ),
                    PlayerProgressBoard(player: player),
                    SafeArea(
                      child: PlayerControlBoard(player: player, url: url),
                    ),
                    isDesktop ? const SizedBox(height: 16) : const SizedBox(height: 0),
                  ],
                ),
            ),
          ],
        ),
      )
    );
  }
}
