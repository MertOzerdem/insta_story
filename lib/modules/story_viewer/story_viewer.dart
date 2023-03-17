import 'package:flutter/material.dart';
import 'package:insta_story/modules/story/controller/story_controller.dart';

import 'package:insta_story/modules/story/story.dart';
import '../../models/story.dart' as model;
import '../progress_bar/controller/progress_bar_controller.dart';
import '../progress_bar/widget/progress_bar.dart';
import '../story/bloc/story_bloc.dart';
import 'cubit/story_viewer_cubit.dart';

enum Direction { next, previous }

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
  final ProgressBarController _progressBarController = ProgressBarController();
  late StoryController _storyController;

  @override
  void dispose() {
    _pageController.dispose();
    _storyViewerCubit.close();
    _storyController.dispose();
    _progressBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.stories.length,
        onPageChanged: (_) {
          _storyController.dispose();
          _progressBarController.clearListener();
        },
        itemBuilder: (context, i) {
          final model.Story story = widget.stories[i];

          _storyController = StoryController(
            storyBloc: StoryBloc(mediaUrl: story.url),
          )..initialize().then((_) {
              _progressBarController
                  .setDuration(_storyController.duration as Duration);
              _progressBarController.forward();
            });

          _progressBarController.listen((status) {
            if (status == AnimationStatus.completed) {
              _animateToStory(Direction.next);
            }
          });

          return StoryPage(
            storyController: _storyController,
            onTapUp: (details) => _onTapUp(details, context),
            onLongPressStart: () => _progressBarController.stop(),
            onLongPressUp: () => _progressBarController.forward(),
          );
        },
      ),
      ProgressBar(
        currentIndex: 0,
        length: widget.stories.length,
        progressBarController: _progressBarController,
      ),
    ]);
  }

  _onTapUp(details, BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    int currentIndex = _storyViewerCubit.state;
    if (dx < screenWidth / 3) {
      if (currentIndex - 1 >= 0) {
        _animateToStory(Direction.previous);
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (currentIndex + 1 < widget.stories.length) {
        _animateToStory(Direction.next);
      } else {
        // Out of bounds - loop story
        // You can also Navigator.of(context).pop() here
      }
    }
  }

  void _animateToStory(Direction direction) {
    _processState(direction);
    _processAnimatedBar(direction);

    _pageController.animateToPage(
      _storyViewerCubit.state,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _processState(Direction direction) {
    if (direction == Direction.next) {
      _storyViewerCubit.increment();
    } else {
      _storyViewerCubit.decrement();
    }
  }

  void _processAnimatedBar(Direction direction) {
    if (direction == Direction.next) {
      _progressBarController.next();
    } else {
      _progressBarController.previous();
    }

    _progressBarController.stop();
    _progressBarController.reset();
  }
}
