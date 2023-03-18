import 'package:flutter/material.dart';
import 'package:insta_story/modules/story/controller/story_controller.dart';

import 'package:insta_story/modules/story/story.dart';
import '../../models/story.dart' as model;
import '../progress_bar/controller/progress_bar_controller.dart';
import '../progress_bar/widget/progress_bar.dart';
import '../story/bloc/story_bloc.dart';
import 'cubit/story_viewer_cubit.dart';

enum Direction { next, previous }

typedef VoidStoryCallback = void Function(model.Story story);

class StoryViewer extends StatefulWidget {
  const StoryViewer({
    super.key,
    required this.stories,
    this.onBoundBreachStart,
    this.onBoundBreachEnd,
    this.onStoryStart,
  });

  final List<model.Story> stories;
  final VoidStoryCallback? onStoryStart;
  final VoidCallback? onBoundBreachStart;
  final VoidCallback? onBoundBreachEnd;

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  late StoryViewerCubit _storyViewerCubit;
  late PageController _pageController;
  late ProgressBarController _progressBarController;
  StoryController? _storyController;
  int firstUnseenStoryIndex = 0;

  @override
  void initState() {
    super.initState();

    firstUnseenStoryIndex = _getFirstUnseenStoryIndex();

    _storyViewerCubit = StoryViewerCubit(firstUnseenStoryIndex);
    _pageController = PageController(initialPage: firstUnseenStoryIndex);
    _progressBarController = ProgressBarController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _storyViewerCubit.close();
    _progressBarController.dispose();
    // _storyController?.dispose();
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
          // _storyController?.dispose();
          _progressBarController.clearListener();
        },
        itemBuilder: (context, i) {
          final model.Story story = widget.stories[i];

          widget.onStoryStart?.call(story);

          _storyController = StoryController(
            storyBloc: StoryBloc(mediaUrl: story.url),
          )..initialize().then((_) {
              _progressBarController.setDuration(
                _storyController?.duration ?? const Duration(seconds: 1),
              );
              _progressBarController.forward();
            });

          _progressBarController.listen((status) {
            if (status == AnimationStatus.completed) {
              if (_storyViewerCubit.state + 1 < widget.stories.length) {
                _animateToStory(Direction.next);
              } else {
                _onSlidesFinish();
              }
            }
          });

          return StoryPage(
            storyController: _storyController!,
            onTapUp: (details) => _onTapUp(details, context),
            onLongPressStart: () => _progressBarController.stop(),
            onLongPressUp: () => _progressBarController.forward(),
          );
        },
      ),
      ProgressBar(
        currentIndex: firstUnseenStoryIndex,
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
      if (currentIndex == 0) {
        widget.onBoundBreachStart?.call();
      } else if (currentIndex > 0) {
        _animateToStory(Direction.previous);
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (currentIndex + 1 < widget.stories.length) {
        _animateToStory(Direction.next);
      } else {
        widget.onBoundBreachEnd?.call();
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

  _onSlidesFinish() {
    widget.onBoundBreachEnd?.call();
  }

  _getFirstUnseenStoryIndex() {
    int firstUnseen = widget.stories.indexWhere((story) => !story.seen);
    if (firstUnseen == -1) {
      firstUnseen = 0;
    }

    return firstUnseen;
  }
}
