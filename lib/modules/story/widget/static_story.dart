import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/story_bloc.dart';

class StaticStory extends StatelessWidget {
  const StaticStory({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: CachedNetworkImage(
        imageUrl: context.read<StoryBloc>().state.mediaUrl,
        fit: BoxFit.fill,
        imageBuilder: (context, imageProvider) {
          context.read<StoryBloc>().add(const StoryFetched());

          return Image(image: imageProvider);
        },
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
