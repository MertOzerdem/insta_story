import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_story/modules/story/controller/story_controller.dart';
import 'dart:math' as math;

import '../bloc/story_bloc.dart';
import '../widget/static_story.dart';
import '../widget/video_story.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({
    super.key,
    required StoryController storyController,
    this.onTapUp,
    this.onLongPressUp,
    this.onLongPressStart,
  }) : _storyController = storyController;

  final GestureTapUpCallback? onTapUp;
  final VoidCallback? onLongPressUp;
  final VoidCallback? onLongPressStart;
  final StoryController _storyController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _storyController.storyBloc,
      child: Story(
        onTapUp: onTapUp,
        onLongPressStart: onLongPressStart,
        onLongPressUp: onLongPressUp,
      ),
    );
  }
}

class Story extends StatelessWidget {
  const Story({
    super.key,
    this.onTapUp,
    this.onLongPressUp,
    this.onLongPressStart,
  });

  final GestureTapUpCallback? onTapUp;
  final VoidCallback? onLongPressUp;
  final VoidCallback? onLongPressStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black87),
      child: GestureDetector(
        onTapUp: (details) => _onTapUp(details, context),
        onLongPressUp: () => _onLongPressUp(context),
        onLongPressStart: (_) => _onLongPressStart(context),
        child: BlocBuilder<StoryBloc, StoryState>(
          builder: (context, state) {
            return state.mediaUrl.contains(".mp4")
                ? const VideoStory()
                : const StaticStory();
          },
        ),
      ),
    );
  }

  void _onTapUp(TapUpDetails details, BuildContext context) {
    context.read<StoryBloc>().add(StoryTappedUp());
    onTapUp?.call(details);
  }

  void _onLongPressUp(BuildContext context) {
    context.read<StoryBloc>().add(StoryLongPressEnded());

    onLongPressUp?.call();
  }

  void _onLongPressStart(BuildContext context) {
    context.read<StoryBloc>().add(StoryLongPressStarted());

    onLongPressStart?.call();
  }
}
