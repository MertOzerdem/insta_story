import '../view/carousel.dart';

class CarouselController {
  CarouselWidgetState? _state;

  setState(CarouselWidgetState state) {
    _state = state;
  }

  nextPage([Duration? transitionDuration]) {
    if (_state != null &&
        _state!.mounted &&
        _state!.widget.children!.isNotEmpty) {
      _state!.nextPage(transitionDuration);
    }
  }

  previousPage([Duration? transitionDuration]) {
    if (_state != null &&
        _state!.mounted &&
        _state!.widget.children!.isNotEmpty) {
      _state!.previousPage(transitionDuration);
    }
  }

  dispose() {
    if (_state!.mounted) {
      _state!.dispose();
    }
  }
}
