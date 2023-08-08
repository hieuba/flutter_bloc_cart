part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ProductDataModels> products;

  HomeSuccessState({required this.products});
}

//scafoldmessenger
class HomeNavigateToCartActionState extends HomeActionState {}

class HomeProductItemCartedActionState extends HomeActionState {}
