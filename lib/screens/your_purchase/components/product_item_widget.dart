import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/urls.dart';
import '../../../model/cart_history_item.dart';
import '../../components/custom_cache_network_image.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.productItem,
  });

  final OrderItem productItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          CustomCacheNetworkImage(
            imageUrl: "${productItem.imageUrl}",
            height: 90,
            width: 90,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productItem.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${productItem.price}\$",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Quantity: ${productItem.quantity}",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
