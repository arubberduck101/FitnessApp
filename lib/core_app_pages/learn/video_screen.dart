import '../../firebase/db.dart';
import './play_video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// import '../firebase/db.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Map links = {
    '10 MIN BEGINNER AB WORKOUT': 'https://youtu.be/uUKAYkQZXko',
  };
  // Map links = {};
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideos();
  }

  getVideos() async {
    getVideoFiles().then((value) => setState(() {
          print(value);
          if (value != null) links = value!;
        }));
    Future.delayed(const Duration(seconds: 5)).then((value) {
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? links.isNotEmpty
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: links!.length,
                    itemBuilder: (BuildContext context, int index) {
                      String title = links.keys.elementAt(index);
                      return Card(
                          child: ListTile(
                        title: Text(title.substring(0, title.length - 4)),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_circle),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayVideoPage(
                                          url: links![title],
                                          title: title.substring(
                                              0, title.length - 4),
                                        )));
                          },
                        ),
                      ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ))
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No videos found'),
                    )
                  ],
                ))
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Loading Videos ...'),
                )
              ],
            )),
    );
  }
}
