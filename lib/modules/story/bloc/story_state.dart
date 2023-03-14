part of 'story_bloc.dart';

enum StoryStatus { initial, initialized, playing, paused, failure }

class StoryState extends Equatable {
  StoryState({
    this.storyStatus = StoryStatus.initial,
    required this.mediaUrl,
  });

  StoryStatus storyStatus;
  final String mediaUrl;

  @override
  List<Object> get props => [storyStatus];
}

// class StoryLoading extends StoryState {}

// class StoryInitialized extends StoryState {}

// class StoryPlaying extends StoryState {}

// class StoryPaused extends StoryState {}

// class StoryErrored extends StoryState {}
