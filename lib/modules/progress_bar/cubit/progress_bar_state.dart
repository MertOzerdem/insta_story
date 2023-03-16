part of 'progress_bar_cubit.dart';

class ProgressBarState extends Equatable {
  const ProgressBarState({required currentIndex, required listLength})
      : _currentIndex = currentIndex,
        _listLength = listLength;

  final int _listLength;
  final int _currentIndex;

  int get listLength => _listLength;
  int get currentIndex => _currentIndex;

  ProgressBarState copyWith({int? currentIndex, int? listLength}) {
    return ProgressBarState(
      currentIndex: currentIndex ?? _currentIndex,
      listLength: listLength ?? _listLength,
    );
  }

  @override
  List<Object> get props => [currentIndex, listLength];
}
