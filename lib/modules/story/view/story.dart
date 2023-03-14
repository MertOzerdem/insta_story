import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import '../bloc/story_bloc.dart';
import '../widget/static_story.dart';
import '../widget/video_story.dart';

class Story extends StatelessWidget {
  const Story({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0)),
      child: GestureDetector(
          onTapUp: (details) => _onTapUp(details, context),
          child: BlocBuilder<StoryBloc, StoryState>(
            builder: (context, state) {
              return state.mediaUrl.contains(".mp4")
                  ? const VideoStory()
                  : const StaticStory();
            },
          )),
    );
  }

  void _onTapUp(TapUpDetails details, BuildContext context) {
    context.read<StoryBloc>().add(StoryTappedUp());
  }
}
