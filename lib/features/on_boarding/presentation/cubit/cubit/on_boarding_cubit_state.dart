part of 'on_boarding_cubit_cubit.dart';

sealed class OnBoardingCubitState extends Equatable {
   final  int currentIndex ;
  const OnBoardingCubitState(this.currentIndex);

  @override
  List<Object> get props => [];
}

class OnBoardingCubitInitial extends OnBoardingCubitState {
  const OnBoardingCubitInitial() : super(0);
}
class OnBoardingCubitPageChanged extends OnBoardingCubitState {
  final int currentIndex;
  const OnBoardingCubitPageChanged(int index) : currentIndex = index, super(index);

  @override
  List<Object> get props => [currentIndex];
}

 