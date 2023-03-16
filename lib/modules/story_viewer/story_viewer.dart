import 'package:flutter/material.dart';
import 'package:insta_story/modules/story/controller/story_controller.dart';

import 'package:insta_story/modules/story/story.dart';
import '../../models/story.dart' as model;
import '../progress_bar/widget/progress_bar.dart';
import '../story/bloc/story_bloc.dart';
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
  late StoryController _storyController;

  @override
  void dispose() {
    _pageController.dispose();
    _storyViewerCubit.close();
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.stories.length,
        onPageChanged: (_) => _storyController.dispose(),
        itemBuilder: (context, i) {
          final model.Story story = widget.stories[i];

          _storyController = StoryController(
            storyBloc: StoryBloc(mediaUrl: story.url),
          )..initialize().then((_) {
              print('duration ${_storyController.duration}');
            });

          return StoryPage(
            storyController: _storyController,
            onTapUp: (details) => loadAction(details, context),
            onLongPressStart: () => print('long start'),
            onLongPressUp: () => print('long end'),
          );
        },
      ),
      const ProgressBar(
        currentIndex: 0,
        length: 3,
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
