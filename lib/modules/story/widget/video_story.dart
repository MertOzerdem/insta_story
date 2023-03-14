import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../bloc/story_bloc.dart';

class VideoStory extends StatefulWidget {
  const VideoStory({super.key});

  @override
  State<VideoStory> createState() => _VideoStoryState();
}

class _VideoStoryState extends State<VideoStory> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late StoryBloc _storyBloc;

  @override
  void initState() {
    super.initState();
    _storyBloc = context.read<StoryBloc>();

    _controller = VideoPlayerController.network(_storyBloc.state.mediaUrl);

    // _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeController(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _storyBloc.add(StoryFetched());
          return FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> _initializeController() async {
    await _controller.initialize();

    _controller.play();
  }
}
