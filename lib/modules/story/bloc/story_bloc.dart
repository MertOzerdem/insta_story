import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required String mediaUrl})
      : super(StoryState(
          mediaUrl: mediaUrl,
          storyStatus: StoryStatus.initial,
        )) {
    on<StoryEvent>((StoryEvent event, Emitter<StoryState> emit) {});
    on<StoryFetched>(_onStoryFetched);
    on<StoryLongPressStarted>(_onStoryPaused);
    on<StoryLongPressEnded>(_onStoryResumed);
  }

  @override
  void onChange(Change<StoryState> change) {
    super.onChange(change);
    // print('change $change');
  }

  void _onStoryFetched(StoryFetched event, Emitter<StoryState> emit) {
    emit(
      state.copyWith(
        storyStatus: StoryStatus.initialized,
        duration: event.duration,
      ),
    );
  }

  void _onStoryPaused(StoryEvent event, Emitter<StoryState> emit) {
    emit(
      state.copyWith(
        storyStatus: StoryStatus.paused,
      ),
    );
  }

  void _onStoryResumed(StoryEvent event, Emitter<StoryState> emit) {
    emit(
      state.copyWith(
        storyStatus: StoryStatus.resumed,
      ),
    );
  }
}
