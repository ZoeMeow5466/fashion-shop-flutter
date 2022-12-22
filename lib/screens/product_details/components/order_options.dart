import 'package:flutter/material.dart';

import '../../../config/variables.dart';
import 'amount_selector.dart';
import 'color_selector.dart';
import 'current_state.dart';
import 'product_size_selector.dart';

class OrderOptions extends StatelessWidget {
  const OrderOptions({
    super.key,
    this.availableColors,
    this.availableSize,
    this.inventoryMax = -1,
    required this.currentState,
    required this.onStateChanged,
  });

  final List<int>? availableColors;
  final List<String>? availableSize;
  final CurrentState currentState;
  final Function(CurrentState) onStateChanged;
  final int inventoryMax;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Card(
        color: Variables.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            availableSize == null
                ? const Center()
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ProductSizeSelector(
                      sizeList: availableSize!,
                      selectedIndex: currentState.selectedSizeIndex,
                      onClickedSize: (sizeSelected) {
                        var data = currentState;
                        data.selectedSizeIndex = sizeSelected;
                        onStateChanged(data);
                      },
                    ),
                  ),
            availableColors == null
                ? const Center()
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ColorSelector(
                      availableColors: availableColors!,
                      selectedColor: currentState.selectedColor,
                      dotSize: 40,
                      onClick: (color) {
                        var data = currentState;
                        data.selectedColor = color;
                        onStateChanged(data);
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: AmountSelector(
                count: currentState.selectedCount,
                countMax: inventoryMax,
                onChanged: (newCount) {
                  var data = currentState;
                  data.selectedCount = newCount;
                  onStateChanged(data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
