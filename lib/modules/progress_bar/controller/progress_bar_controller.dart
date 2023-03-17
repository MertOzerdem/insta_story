import 'package:flutter/material.dart';

import '../widget/progress_bar.dart';

class ProgressBarController {
  ProgressBarWidgetState? _state;

  setControllerState(ProgressBarWidgetState state) {
    _state = state;
  }

  void setDuration(Duration duration) {
    _state?.setDuration(duration);
  }

  void next() {
    _state?.next();
  }

  void previous() {
    _state?.previous();
  }

  void forward() {
    _state?.forward();
  }

  void stop() {
    _state?.stop();
  }

  void reset() {
    _state?.reset();
  }

  void listen(Function(AnimationStatus) callback) {
    _state?.listen(callback);
  }

  void clearListener() {
    _state?.clearListener();
  }

  dispose() {
    if (_state!.mounted) {
      _state!.dispose();
    }
  }
}
