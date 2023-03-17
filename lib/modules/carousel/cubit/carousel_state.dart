part of 'carousel_cubit.dart';

class CarouselState extends Equatable {
  const CarouselState({required int currentPage, double pageDelta = 0})
      : _currentPage = currentPage,
        _pageDelta = pageDelta;

  final int _currentPage;
  final double _pageDelta;

  int get currentPage => _currentPage;
  double get pageDelta => _pageDelta;

  CarouselState copyWith({int? currentPage, double? pageDelta}) {
    return CarouselState(
      currentPage: currentPage ?? _currentPage,
      pageDelta: pageDelta ?? _pageDelta,
    );
  }

  @override
  List<Object> get props => [_currentPage, _pageDelta];
}
