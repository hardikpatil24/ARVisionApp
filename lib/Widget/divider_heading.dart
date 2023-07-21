import 'package:flutter/material.dart';

class DividerHeading extends StatelessWidget {
  const DividerHeading({super.key, required this.heading});
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 9,
        right: 9,
        top: 20,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Divider(
              thickness: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              heading,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
              child: Divider(
            thickness: 1.5,
          )),
        ],
      ),
    );
  }
}
