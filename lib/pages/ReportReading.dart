import 'package:flutter/material.dart';
class ReportReading extends StatelessWidget {
  const ReportReading({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF00E5FF),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/reading_bg.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              BoardHeader(),
            ],
          ),
        ),
      ),
    );
  }
}

class BoardHeader extends StatelessWidget {
  const BoardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 74.0, left: 8.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 226,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/reading_header_bg.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            _headerUserInfo(),
            _headerCourseData(),
          ],
        ),
      ),
    );
  }
}

Widget _headerUserInfo () {
  return Column(
    verticalDirection: VerticalDirection.up,
    children: [
      Container(
        width: double.infinity,
        height: 46.0,
        padding: const EdgeInsets.only(top: 6.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/reading_header_name_bg.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          )
        ),
        child: const Center(
          child: Text(
            '小核桃',
            style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),),
        ),
      ),
      Container(
        width: 84.0,
        height: 84.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(top: 12.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(42.0)),
          color: Colors.white,
        ),
        child: Image.asset('assets/images/default_avatar.png'),
      ),
    ],
  );
}

Widget _headerCourseData () {
  return Row(
    children: [
      CourseDataItem(label: '阅读时长', value: '20', ceil: '分钟'),
      CourseDataItem(label: '闯关答题', value: '20', ceil: '次'),
      CourseDataItem(label: '互动次数', value: '20', ceil: '次'),
    ],
  );
}

class CourseDataItem extends StatelessWidget {
  const CourseDataItem ({Key? key,  required this.label, required this.value, required this.ceil}) : super(key: key);
  final String label;
  final String value;
  final String ceil;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14.6,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(40, 0, 0, 0),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(100, 162, 91, 34),
            )
          ),
          Text(
            ceil,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(100, 202, 159, 122),
            )
          ),
        ]),
      ),
    ],)
  );
  }
}