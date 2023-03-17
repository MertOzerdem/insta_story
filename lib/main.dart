import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_story/modules/carousel/view/carousel.dart';

import 'custom_bloc_observer.dart';
import 'mock/stories.dart';
import 'modules/carousel/controller/carousel_controller.dart';
import 'modules/story_viewer/story_viewer.dart';

void main() {
  // Bloc.observer = CustomBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Carousel(
          controller: _carouselController,
          children: [
            StoryViewer(
              key: Key('s1'),
              stories: stories,
            ),
            StoryViewer(
              key: Key('s2'),
              stories: stories,
            ),
            StoryViewer(
              key: Key('s3'),
              stories: stories,
            ),
          ],
        ),
      ),
    );
  }
}
