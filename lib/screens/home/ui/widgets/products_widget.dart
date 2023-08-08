import 'package:flutter/material.dart';
import 'package:flutter_bloc_cart/models/products_model.dart';
import 'package:flutter_bloc_cart/screens/home/bloc/home_bloc.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({
    super.key,
    required this.homeBloc,
    required this.productData,
  });

  final ProductDataModels productData;
  final HomeBloc homeBloc;

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    final customColor = Color(
        int.parse(widget.productData.color.substring(1, 7), radix: 16) +
            0xFF000000);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: customColor,
          ),
          child: Transform.rotate(
            angle: 12,
            child: Container(
              width: double.infinity,
              child: Image.network(widget.productData.image),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          widget.productData.name,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, height: 1.5),
        ),
        const SizedBox(height: 15),
        Text(
          widget.productData.description,
          style: const TextStyle(fontSize: 13, height: 1.8),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '\$${widget.productData.price}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 1.5),
            ),
            const Spacer(),
            Expanded(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue),
                child: GestureDetector(
                  onTap: () {
                    widget.homeBloc.add(HomeProductsCartButtonClickedEvent(
                        clikedProducts: widget.productData));
                    setState(() {
                      isAddedToCart = true;
                    });
                  },
                  child: isAddedToCart
                      ? const Center(
                          child: Icon(Icons.check),
                        )
                      : const Center(child: Text('add to cart')),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}
