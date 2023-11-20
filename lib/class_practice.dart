import 'package:flutter/material.dart';
import 'package:scroll_controller/main.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return ScrollPage();
  }
}