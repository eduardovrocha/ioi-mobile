import 'package:flutter/material.dart';

import '../../../models/collect_list_item_data.dart';

class CollectItemWidget extends StatelessWidget {
  final CollectListItemData collectItem;

  const CollectItemWidget({super.key, required this.collectItem});

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(16);
    var applyShadow = BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 2,
      offset: Offset(0, 1),
    );
    const baseBorder = BorderSide(
      color: Colors.black12,
      width: 1,
    );
    const border = Border(
      bottom: baseBorder,
      top: baseBorder,
      right: baseBorder,
      left: baseBorder,
    );

    var emptyResult = collectItem.emptyPercentage;

    return Container(
      margin: const EdgeInsets.only(
          left: 15.0, top: 5, right: 15.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: border,
        boxShadow: [if (true) applyShadow],
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 5.0),
                  child: Text(collectItem.shopName),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 15.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (emptyResult <= 0)
                          ? Image.asset(
                        'assets/images/resources-030.png',
                        width: 24,
                        height: 24,
                      )
                          : Image.asset(
                        'assets/images/resources-028.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '${(emptyResult >= 0) ? '-' : ' '} ${collectItem.emptyPercentage}%',
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 5.0, bottom: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            imageWithFallback(collectItem.categoryNumber),
                            const SizedBox(width: 8.0),
                            Text(
                              'R\$ ${collectItem.currencyAmount}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Text(
                              '\$MC3 ${collectItem.tokenAmount}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                            const SizedBox(width: 10.0),
                            Image.asset(
                              'assets/images/resources-029.png',
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Image imageWithFallback(String assetPath) {
    return Image.asset(
      'assets/images/$assetPath.png', width: 24, height: 24,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
            'assets/images/1091102.png',
            width: 24, height: 24
        );
      },
    );
  }
}
