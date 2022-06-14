import 'package:flutter/material.dart';
class ReportReading extends StatelessWidget {
  const ReportReading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Report Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.of(context).pop();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}