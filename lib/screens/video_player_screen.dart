import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String movieURL; // 動画URL
  VideoPlayerScreen(this.movieURL) : super();

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// /*
//  * 動画ウィジェット
//  */
// class MoviePlayerWidget extends StatefulWidget {

//   final String movieURL; // 動画URL
//   MoviePlayerWidget(this.movieURL) : super();

//   @override
//   _MoviePlayerWidgetState createState() => _MoviePlayerWidgetState();
// }

// /*
//  * ステート
//  */
// class _MoviePlayerWidgetState extends State<MoviePlayerWidget> {

//   // コントローラー
//   VideoPlayerController _controller;
//   VoidCallback _listener;
//   bool _isPlayComplete = false;

//   @override
//   void initState() {

//     // 動画プレーヤーの初期化
//     _controller = VideoPlayerController.network(
//         widget.movieURL
//     )..initialize().then((_) {

//       setState(() {});

//       _controller.play();

//       // イベント監視
//       _listener = () {
//         if (!_controller.value.isPlaying) {

//           // 再生完了
//           setState(() {
//             _isPlayComplete = true;
//           });
//         }
//       };
//       _controller.addListener(_listener);
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(_controller.value.aspectRatio);

//     if (_controller == null) return Container();

//     if (_controller.value.initialized) {

//       /*
//        * 動画
//        */
//       return Container(
//         child: AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: Stack(
//             children: <Widget>[

//               /*
//                * 動画プレーヤー
//                */
//               VideoPlayer(_controller),

//               _isPlayComplete ? InkWell(
//                 onTap: (() {

//                   setState(() {
//                     _isPlayComplete = false;
//                   });
//                   _controller.seekTo(Duration.zero);
//                   _controller.play();

//                 }),
//                 child: Center(
//                   child: Icon(
//                     Icons.play_circle_outline,
//                     color: Colors.white,
//                     size: 50.0,
//                   ),
//                 ),
//               )
//                   : Container()
//             ],
//           ),
//         ),
//       );
//     } else {

//       /*
//        * インジケータを表示
//        */
//       return Container(
//         height: 150.0,
//         child: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_listener);
//     _controller.dispose();
//     super.dispose();
//   }
// }
