import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cart/screens/cart/ui/cart_screen.dart';
import 'package:flutter_bloc_cart/screens/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_cart/screens/home/ui/widgets/products_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeNavigateToCartActionState) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartScreen(),
          ));
        }
      },
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      bloc: homeBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          case HomeSuccessState:
            final successState = state as HomeSuccessState;
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
                            'Our products',
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(0xff303841),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              homeBloc.add(CartButtonNavigateEvent());
                            },
                            icon: const Icon(Icons.shopping_cart_checkout))
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 110, left: 30, right: 30),
                      child: ListView.builder(
                        itemCount: successState.products.length,
                        itemBuilder: (context, index) {
                          return ProductsWidget(
                              homeBloc: homeBloc,
                              productData: successState.products[index]);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
