import '../bloc/story_bloc.dart';

class StoryController {
  StoryController({required StoryBloc storyBloc}) : _storyBloc = storyBloc;

  final StoryBloc _storyBloc;
  bool _initialized = false;
  Duration? _duration;

  StoryBloc get storyBloc => _storyBloc;
  bool get initialized => _initialized;
  Duration? get duration => _duration;

  Future<void> initialize() async {
    StoryState state = await _storyBloc.stream.first;
    if (state.storyStatus == StoryStatus.initialized) {
      _initialized = true;
      _duration = state.duration;
    }
  }

  dispose() {
    _storyBloc.close();
  }
}
