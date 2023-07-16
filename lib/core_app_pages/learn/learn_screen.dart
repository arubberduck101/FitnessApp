import 'package:flutter/material.dart';
import './tip_screen.dart';
import './video_screen.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return const VideoPage();
  }
}

// do the tip screen and video item screen