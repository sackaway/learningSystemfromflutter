import 'package:flutter/material.dart';
import 'package:learningsystem/providers/progress_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String courseId;
  final String sectionTitle;

  VideoPlayerPage({required this.videoUrl, required this.courseId, required this.sectionTitle});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: true,
          looping: false,
        );
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sectionTitle)),
      body: Column(
        children: [
          _chewieController != null ? Chewie(controller: _chewieController!) : CircularProgressIndicator(),
          ElevatedButton(
            onPressed: () {
              context.read<ProgressProvider>().completeSection(widget.courseId, widget.sectionTitle);
              Navigator.pop(context);
            },
            child: Text("Mark as Completed"),
          ),
        ],
      ),
    );
  }
}
