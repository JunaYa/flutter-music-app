
import 'package:app/pages/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const Color _gredientBgColor1 = Color.fromARGB(255, 24, 25, 28);
const Color _gredientBgColor2 = Color.fromARGB(255, 56, 58, 64);
const Color _gredientColor1 = Color.fromARGB(255, 42, 41, 45);
const Color _gredientColor2 = Color.fromRGBO(22, 17, 22, 1);


class HeaderBoard extends StatelessWidget {
  const HeaderBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const ButtonIcon(child: Icon(
              Icons.arrow_back, color: Colors.white, size: 24.0),
            ),
          ),
          Text('play now'.toUpperCase(), style: const TextStyle(color: Colors.white),),
          const ButtonIcon(child: Icon(
            Icons.list,
            color: Colors.white,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          )),
        ],
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  final Widget child;
  const ButtonIcon({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    ).addNeumorphism(
      blurRadius: 10,
      borderRadius: 30,
      offset: const Offset(5, 5),
      topShadowColor: const Color.fromARGB(255, 60, 66, 73),
      bottomShadowColor: const Color.fromARGB(255, 38, 43, 48),
    );
  }

}