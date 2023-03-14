import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_story/modules/story/bloc/story_bloc.dart';

import 'story.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key, required String mediaUrl}) : _mediaUrl = mediaUrl;

  final String _mediaUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryBloc(mediaUrl: _mediaUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Story(),
      ),
    );
  }
}
