import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required String mediaUrl})
      : super(StoryState(mediaUrl: mediaUrl)) {
    on<StoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  void onChange(Change<StoryState> change) {
    super.onChange(change);
    print('change $change');
  }
}
