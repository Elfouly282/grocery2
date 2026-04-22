import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_cubit_state.dart';

class OnBoardingCubitCubit extends Cubit<OnBoardingCubitState> {
  OnBoardingCubitCubit() : super(OnBoardingCubitInitial());

  void pageChanged(int index) {
    emit(OnBoardingCubitPageChanged(index));
  }

}

 