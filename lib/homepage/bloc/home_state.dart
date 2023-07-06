part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSucessState extends HomeState {
  final Homemodel homemodel;

  HomeSucessState(this.homemodel);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
