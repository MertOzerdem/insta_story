part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class StoryFetched extends StoryEvent {
  const StoryFetched([this.duration = const Duration(seconds: 5)]);

  final Duration duration;
}

class StoryPlayed extends StoryEvent {}

class StoryResumed extends StoryEvent {}

class StoryPaused extends StoryEvent {}

class StoryTappedUp extends StoryEvent {}

class StoryLongPressStarted extends StoryEvent {}

class StoryLongPressEnded extends StoryEvent {}
