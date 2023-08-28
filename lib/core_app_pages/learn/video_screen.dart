import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<Map<String, String>> videos = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  getVideos() async {
    // Simulate fetching video links from the database
    // hi
    //Harry
    //Moga
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      videos = [
        {
          'title': 'Full body workout',
          'url': 'https://www.youtube.com/watch?v=xoUHMebjFSs',
        },
        {
          'title': 'AB workout',
          'url': 'https://www.youtube.com/watch?v=uUKAYkQZXko',
        },
        {
          'title': 'Tricep Workout',
          'url': 'https://www.youtube.com/watch?v=rj0eWvZ4Deo&t=2s',
        },
        {
          'title': 'Bicep Workout',
          'url': 'https://www.youtube.com/watch?v=CLccU7tk7es',
        },
        {
          'title': 'Leg workouts Workout',
          'url': 'https://www.youtube.com/watch?v=H6mRkx1x77k',
        },
        {
          'title': 'Back Workout',
          'url': 'https://www.youtube.com/watch?v=DXL18E7QRbk',
        },
        // Add more dummy video data here
      ];
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Video Page'),
      ),
      body: loading
          ? videos.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        String title = videos[index]['title']!;
                        String videoUrl = videos[index]['url']!;
                        return Card(
                          child: ListTile(
                            title: Text(title),
                            trailing: IconButton(
                              icon: const Icon(Icons.play_circle),
                              onPressed: () {
                                _launchYouTubeURL(videoUrl);
                              },
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                )
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
                  ),
                )
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
              ),
            ),
    );
  }

  void _launchYouTubeURL(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoPlayerScreen(
          videoUrl: url,
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {
            // Perform any actions you want when the player is ready.
          },
          onEnded: (YoutubeMetaData metaData) {
            // Perform any actions you want when the video ends.
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VideoPage(),
  ));
}
