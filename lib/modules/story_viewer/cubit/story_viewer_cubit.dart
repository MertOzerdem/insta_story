import 'package:bloc/bloc.dart';

class StoryViewerCubit extends Cubit<int> {
  final int _startIndex;

  StoryViewerCubit([this._startIndex = 0]) : super(_startIndex);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
