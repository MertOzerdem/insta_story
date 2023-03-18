import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_bloc_observer.dart';
import 'mock/stories.dart';
import 'models/story.dart';
import 'modules/carousel/view/carousel.dart';
import 'modules/carousel/controller/carousel_controller.dart';
import 'modules/story_viewer/story_viewer.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: Carousel(
          controller: _carouselController,
          children: _getStories(),
        ),
      ),
    );
  }

  List<Widget> _getStories() {
    return user.storyGroups.map((storyGroup) {
      return StoryViewer(
        stories: storyGroup.stories,
        onBoundBreachEnd: () => _onBoundBreachEnd(),
        onBoundBreachStart: () => _onBoundBreachStart(),
        onStoryStart: (story) => _onStoryStart(story),
      );
    }).toList();
  }

  void _onBoundBreachStart() {
    _carouselController.previousPage();
  }

  void _onBoundBreachEnd() {
    _carouselController.nextPage();
  }

  void _onStoryStart(Story story) {
    story.seen = true;
  }
}
