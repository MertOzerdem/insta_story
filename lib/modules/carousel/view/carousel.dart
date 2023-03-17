import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/carousel_controller.dart';
import '../cubit/carousel_cubit.dart';
import '../util/cubic_transform.dart';

const _kMaxValue = 200000000000;
const _kMiddleValue = 100000;

typedef CarouselSlideBuilder = Widget Function(int index);

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
    required List<Widget> this.children,
    this.slideTransform = const CubicTransform(),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOut,
    this.isLoopAllowed = false,
    this.initialPage = 0,
    this.onSlideChanged,
    this.onSlideStart,
    this.onSlideEnd,
    this.controller,
  })  : itemCount = children.length,
        super(key: key);

  final List<Widget>? children;
  final int itemCount;
  final CubicTransform slideTransform;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool isLoopAllowed;
  final int initialPage;
  final ValueChanged<int>? onSlideChanged;
  final VoidCallback? onSlideStart;
  final VoidCallback? onSlideEnd;
  final CarouselController? controller;

  @override
  State<StatefulWidget> createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<Carousel> {
  PageController? _pageController;
  late CarouselCubit _carouselCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _carouselCubit,
      child: Stack(
        children: <Widget>[
          if (widget.itemCount > 0)
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  widget.onSlideStart?.call();
                } else if (notification is ScrollEndNotification) {
                  widget.onSlideEnd?.call();
                }
                return true;
              },
              child: PageView.builder(
                onPageChanged: (val) {
                  widget.onSlideChanged?.call(val);
                },
                scrollBehavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                  overscroll: false,
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse
                  },
                ),
                itemCount: widget.isLoopAllowed ? _kMaxValue : widget.itemCount,
                controller: _pageController,
                itemBuilder: (context, index) {
                  final slideIndex = index % widget.itemCount;
                  return BlocBuilder<CarouselCubit, CarouselState>(
                    builder: (context, state) {
                      return widget.slideTransform.transform(
                        context,
                        widget.children![slideIndex],
                        index,
                        state.currentPage,
                        state.pageDelta,
                        widget.itemCount,
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant Carousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemCount != widget.itemCount) {
      _initPageController();
    }
    _initCarouselController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
    _carouselCubit.close();
  }

  @override
  void initState() {
    super.initState();
    _carouselCubit = CarouselCubit(widget.initialPage);
    _initCarouselController();
    _initPageController();
  }

  void _initCarouselController() {
    if (widget.controller != null) {
      widget.controller?.setState(this);
    }
  }

  void _initPageController() {
    _pageController?.dispose();
    _pageController = PageController(
      initialPage: widget.isLoopAllowed
          ? _kMiddleValue * widget.itemCount + _carouselCubit.state.currentPage
          : _carouselCubit.state.currentPage,
    );
    _pageController!.addListener(() {
      _carouselCubit.setValues(
        currentPage: _pageController?.page?.floor(),
        pageDelta: _pageController!.page! - _pageController!.page!.floor(),
      );
    });
  }

  void nextPage(Duration? transitionDuration) {
    _pageController!.nextPage(
      duration: transitionDuration ?? widget.animationDuration,
      curve: widget.animationCurve,
    );
  }

  void previousPage(Duration? transitionDuration) {
    _pageController!.previousPage(
      duration: transitionDuration ?? widget.animationDuration,
      curve: widget.animationCurve,
    );
  }
}
