import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_cart/data/cart_item.dart';
import 'package:flutter_bloc_cart/data/shoes.dart';
import 'package:flutter_bloc_cart/models/products_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeProductsCartButtonClickedEvent>(homeProductsCartButtonClickedEvent);
    on<CartButtonNavigateEvent>(cartButtonNavigateEvent);

    on<HomeInitEvent>(homeInitEvent);
  }

  FutureOr<void> homeProductsCartButtonClickedEvent(
      HomeProductsCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('products wishlist clicked');
    cartItems.add(event.clikedProducts);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> cartButtonNavigateEvent(
      CartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('products cart navigate');
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> homeInitEvent(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeSuccessState(
      products: ProductData.products.map((e) {
        return ProductDataModels(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            price: e['price'],
            image: e['image'],
            color: e['color']);
      }).toList(),
    ));
  }
}
