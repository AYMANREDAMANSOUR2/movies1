import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  static const String routeName = '  vid ';

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(
        "https://st4.depositphotos.com/9301586/22871/v/600/depositphotos_228712898-stock-video-soon-particle-text.mp4");
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video "),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          Container(
            //duration of video
            child: Text(
              "Total Duration: " + controller.value.duration.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
              height: 6,
              child: VideoProgressIndicator(controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    backgroundColor: Colors.blue,
                    playedColor: Colors.blueAccent,
                    bufferedColor: Colors.greenAccent,
                  ))),
          Container(
            color: Colors.black38,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (controller.value.isPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }

                      setState(() {});
                    },
                    icon: Icon(
                      controller.value.isPlaying
                          ? (Icons.pause)
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      controller.seekTo(Duration(seconds: 0));

                      setState(() {});
                    },
                    icon: Icon(Icons.stop))
              ],
            ),
          )
        ])),
      ),
    );
  }
}
