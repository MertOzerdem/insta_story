import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/story_bloc.dart';

class StaticStory extends StatelessWidget {
  const StaticStory({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: context.read<StoryBloc>().state.mediaUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      fit: BoxFit.cover,
    );
  }
}
