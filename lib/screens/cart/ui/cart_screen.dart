import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cart/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_cart/screens/cart/ui/widgets/cart_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      buildWhen: (previous, current) => current is! CartActionState,
      listenWhen: (previous, current) => current is CartActionState,
      listener: (context, state) {
        if (state is CartItemDeletedActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Deleted')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartSuccessState:
            final successState = state as CartSuccessState;
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(150)),
                          color: Color(0xffF6C90E),
                        ),
                        height: 250,
                        width: 140,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      child: Image.asset(
                        'assets/images/nike.png',
                        fit: BoxFit.cover,
                        scale: 6,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 30, top: 70),
                          child: const Text(
                            'Your Cart',
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(0xff303841),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Text('total: 12324'),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 110, left: 30, right: 30),
                      child: ListView.builder(
                        itemCount: successState.cartItems.length,
                        itemBuilder: (context, index) {
                          return CartWidget(
                            cartBloc: cartBloc,
                            productDataModels: successState.cartItems[index],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
