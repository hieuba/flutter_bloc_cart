part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class HomeProductsCartButtonClickedEvent extends HomeEvent {
  final ProductDataModels clikedProducts;
  HomeProductsCartButtonClickedEvent({
    required this.clikedProducts,
  });
}

class CartButtonNavigateEvent extends HomeEvent {}
