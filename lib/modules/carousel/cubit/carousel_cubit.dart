import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit(int currentPage)
      : super(CarouselState(currentPage: currentPage));

  void setValues({int? currentPage, double? pageDelta}) {
    emit(state.copyWith(currentPage: currentPage, pageDelta: pageDelta));
  }
}
