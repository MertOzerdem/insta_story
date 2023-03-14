import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_bloc_observer.dart';
import 'mock/stories.dart';
import 'modules/story_viewer/story_viewer.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StoryViewer(
          stories: stories,
        ),
      ),
    );
  }
}
