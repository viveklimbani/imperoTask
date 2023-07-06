import 'package:flutter/material.dart';

class EndOfLineScreen extends StatefulWidget {
  const EndOfLineScreen({Key? key}) : super(key: key);

  @override
  _EndOfLineScreenState createState() => _EndOfLineScreenState();
}

class _EndOfLineScreenState extends State<EndOfLineScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("End of Line"),
      ),
    );
  }
}
