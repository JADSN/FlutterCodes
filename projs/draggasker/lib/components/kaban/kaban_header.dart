import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KabanHeader extends StatelessWidget {
  final String title;
  final int totalItems;

  const KabanHeader({
    Key? key,
    required this.title,
    required this.totalItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[500],
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment:
            kIsWeb ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: kIsWeb ? null : const EdgeInsets.only(right: 10.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Chip(
            backgroundColor: Colors.black,
            useDeleteButtonTooltip: false,
            label: Text(
              totalItems.toRadixString(10),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
