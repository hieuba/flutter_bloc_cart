import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_cart/data/cart_item.dart';
import 'package:flutter_bloc_cart/models/products_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModels);
    emit(CartItemDeletedActionState());
    emit(CartSuccessState(cartItems: cartItems));
  }
}
