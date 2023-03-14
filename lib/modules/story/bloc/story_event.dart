part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class StoryFetched extends StoryEvent {}

class StoryTappedUp extends StoryEvent {}

class StoryLongPressStarted extends StoryEvent {}

class StoryLongPressEnded extends StoryEvent {}
