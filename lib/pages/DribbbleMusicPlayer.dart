import 'package:app/pages/extentions.dart';
import 'package:flutter/material.dart';

const Color _gredientColor1 = Color.fromARGB(255, 42, 41, 45);
const Color _gredientColor2 = Color.fromRGBO(22, 17, 22, 1);
const Color _kBackgroundColor = Color.fromARGB(255, 52, 58, 68);

class DribbbleMusicPlayer extends StatelessWidget {
  const DribbbleMusicPlayer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: size.height,
          color: _kBackgroundColor,
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

class PlayerProgressBoard extends StatelessWidget {
  const PlayerProgressBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Stack(
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
                child: Container(
                  width: 19,
                  // color: const Color.fromARGB(255, 202, 84, 33),
                ),
              ),
              Positioned(
                left: 0,
                right: 200,
                child: Container(
                  width: double.infinity,
                  height: 6,
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
                top: -12,
                left: 100,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    color: Color.fromARGB(255, 238, 229, 97),
                    border: Border.all(color: _gredientColor2, width: 12),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: <Color>[
                    //     _gredientColor1,
                    //     _gredientColor2,
                    //   ], // Gradient from https://learnui.design/tools/gradient-generator.html
                    //   tileMode: TileMode.mirror,
                    // ),
                  ),
                ).addNeumorphism(
                  blurRadius: 10,
                  borderRadius: 18,
                  offset: const Offset(5, 5),
                  topShadowColor: const Color.fromARGB(255, 60, 66, 73),
                  bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
  
  void setState(Null Function() param0) {}

}

class PlayerControlBoard extends StatelessWidget {
  const PlayerControlBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
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
            child: const Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ).addNeumorphism(
            blurRadius: 10,
            borderRadius: 28,
            offset: const Offset(5, 5),
            topShadowColor: const Color.fromARGB(255, 60, 66, 73),
            bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
          ),
          Container(
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
            child: const Icon(
              Icons.pause,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ).addNeumorphism(
            blurRadius: 10,
            borderRadius: 40,
            offset: const Offset(5, 5),
            topShadowColor: const Color.fromARGB(255, 60, 66, 73),
            bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
          ),
          Container(
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
            child: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ).addNeumorphism(
            blurRadius: 10,
            borderRadius: 28,
            offset: const Offset(5, 5),
            topShadowColor: const Color.fromARGB(255, 60, 66, 73),
            bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
          ),
        ],
      )
    );
  }

}