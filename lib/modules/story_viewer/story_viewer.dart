import 'package:flutter/material.dart';

import 'package:insta_story/modules/story/story.dart';
import '../../models/story.dart' as model;
import 'cubit/story_viewer_cubit.dart';

class StoryViewer extends StatefulWidget {
  final List<model.Story> stories;

  const StoryViewer({super.key, required this.stories});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  final StoryViewerCubit _storyViewerCubit = StoryViewerCubit();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    _storyViewerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.stories.length,
        itemBuilder: (context, i) {
          final model.Story story = widget.stories[i];
          return StoryPage(
            mediaUrl: story.url,
            onTapUp: (details) => loadAction(details, context),
            onLongPressStart: () => print('long start'),
            onLongPressUp: () => print('long end'),
          );
        },
      ),
    ]);
  }

  loadAction(details, BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    int currentIndex = _storyViewerCubit.state;
    if (dx < screenWidth / 3) {
      if (currentIndex - 1 >= 0) {
        _storyViewerCubit.decrement();
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (currentIndex + 1 < widget.stories.length) {
        _storyViewerCubit.increment();
      } else {
        // Out of bounds - loop story
        // You can also Navigator.of(context).pop() here
      }
    }

    _pageController.animateToPage(
      _storyViewerCubit.state,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
