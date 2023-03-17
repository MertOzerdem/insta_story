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
  late StoryBloc _storyBloc;

  @override
  void initState() {
    super.initState();
    _storyBloc = context.read<StoryBloc>();

    _controller = VideoPlayerController.network(_storyBloc.state.mediaUrl);

    _controller.initialize().then((_) {
      _storyBloc.add(StoryFetched(_controller.value.duration));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        if (state.storyStatus == StoryStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.storyStatus == StoryStatus.initialized) {
          _controller.play();
        } else if (state.storyStatus == StoryStatus.paused) {
          _controller.pause();
        } else if (state.storyStatus == StoryStatus.resumed) {
          _controller.play();
        }

        return FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        );
      },
    );
  }
}
