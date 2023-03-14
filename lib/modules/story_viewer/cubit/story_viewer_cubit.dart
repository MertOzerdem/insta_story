import 'package:bloc/bloc.dart';

class StoryViewerCubit extends Cubit<int> {
  StoryViewerCubit([startIndex = 0]) : super(startIndex);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
