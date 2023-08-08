import 'package:flutter/material.dart';
import 'package:flutter_bloc_cart/models/products_model.dart';
import 'package:flutter_bloc_cart/screens/cart/bloc/cart_bloc.dart';

class CartWidget extends StatelessWidget {
  const CartWidget(
      {super.key, required this.productDataModels, required this.cartBloc});

  final ProductDataModels productDataModels;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    final customColor = Color(
        int.parse(productDataModels.color.substring(1, 7), radix: 16) +
            0xFF000000);
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: customColor,
            radius: 60,
            child: Image.network(productDataModels.image),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productDataModels.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                const SizedBox(height: 20),
                Text(
                  '\$${productDataModels.price}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    MyButton(
                      icon: Icon(Icons.add),
                      onTap: () {},
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '1',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    MyButton(
                      icon: Icon(Icons.remove),
                      onTap: () {},
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffF6C90E),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                          onPressed: () {
                            cartBloc.add(CartRemoveFromCartEvent(
                                productDataModels: productDataModels));
                          },
                          icon: const Icon(Icons.delete_outline)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Icon icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: const Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(onPressed: () {}, icon: icon),
      ),
    );
  }
}
