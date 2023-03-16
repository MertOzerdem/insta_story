import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'progress_bar_state.dart';

class ProgressBarCubit extends Cubit<ProgressBarState> {
  ProgressBarCubit({int currentIndex = 0, int listLength = 0})
      : super(ProgressBarState(
            currentIndex: currentIndex, listLength: listLength));

  void increment() {
    if (state._currentIndex < state.listLength) {
      emit(state.copyWith(currentIndex: state._currentIndex + 1));
    }
  }

  void decrement() {
    if (state._currentIndex > 0) {
      emit(state.copyWith(currentIndex: state._currentIndex - 1));
    }
  }
}
