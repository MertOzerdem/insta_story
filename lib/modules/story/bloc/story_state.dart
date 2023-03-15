part of 'story_bloc.dart';

enum StoryStatus { initial, initialized, resumed, paused, failure }

class StoryState extends Equatable {
  const StoryState({
    this.storyStatus = StoryStatus.initial,
    this.duration = const Duration(seconds: 5),
    required this.mediaUrl,
  });

  final StoryStatus storyStatus;
  final Duration duration;
  final String mediaUrl;

  StoryState copyWith({StoryStatus? storyStatus, Duration? duration}) {
    return StoryState(
      mediaUrl: mediaUrl,
      duration: duration ?? this.duration,
      storyStatus: storyStatus ?? this.storyStatus,
    );
  }

  @override
  List<Object> get props => [storyStatus];
}
