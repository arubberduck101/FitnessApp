import 'dart:async';
import './video_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';

class PlayVideoPage extends StatefulWidget {
  PlayVideoPage({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  final String url;
  final String title;

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _setVideoController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<void> _setVideoController() async {
    VideoPlayerController controller;
    print('play video ');
    controller = VideoPlayerController.network(widget.url);
    print('network:' + widget.url);

    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _controller != null
          // able to change after you choose both videos
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.42,
                    color: Color(0xFF232222),
                    child: VideoItems(
                      videoPlayerController: _controller!,
                      autoplay: false,
                      looping: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 3,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                  Text(
                    'There was an error playing the video',
                    style: TextStyle(fontSize: 50),
                    selectionColor: Colors.red,
                  ),
                ])),
    );
  }
}
