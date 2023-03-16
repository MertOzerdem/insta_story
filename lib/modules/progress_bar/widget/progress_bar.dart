import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_story/modules/progress_bar/cubit/progress_bar_cubit.dart';

import '../controller/progress_bar_controller.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
    this.currentIndex = 0,
    required this.length,
    this.progressBarController,
  });

  final int currentIndex;
  final int length;
  final ProgressBarController? progressBarController;

  @override
  State<ProgressBar> createState() => ProgressBarWidgetState();
}

class ProgressBarWidgetState extends State<ProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late ProgressBarCubit _progressBarCubit;

  @override
  void initState() {
    super.initState();
    _progressBarCubit = ProgressBarCubit(
      currentIndex: widget.currentIndex,
      listLength: widget.length,
    );

    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _initProgressBarController();
    super.dispose();
  }

  void _initProgressBarController() {
    if (widget.progressBarController != null) {
      widget.progressBarController?.setControllerState(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _progressBarCubit,
      child: Positioned(
        top: 60.0,
        left: 10.0,
        right: 10.0,
        child: Column(
          children: <Widget>[
            Row(children: getAnimatedBars()),
          ],
        ),
      ),
    );
  }

  List<AnimatedBar> getAnimatedBars() {
    return List.generate(widget.length, (index) {
      return AnimatedBar(
        animationController: _animationController,
        position: index,
      );
    }, growable: false);
  }

  void next() {
    _progressBarCubit.increment();
  }

  void previous() {
    _progressBarCubit.decrement();
  }

  void forward() {
    _animationController.forward();
  }

  void stop() {
    _animationController.stop();
  }

  void reset() {
    _animationController.reset();
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.animationController,
    required this.position,
  });

  final AnimationController animationController;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder<ProgressBarCubit, ProgressBarState>(
              builder: (context, state) {
                return Stack(
                  children: <Widget>[
                    _buildContainer(
                      double.infinity,
                      position < state.currentIndex
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                    position == state.currentIndex
                        ? AnimatedBuilder(
                            animation: animationController,
                            builder: (context, child) {
                              return _buildContainer(
                                constraints.maxWidth *
                                    animationController.value,
                                Colors.white,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
