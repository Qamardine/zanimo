import 'package:flutter/material.dart';
import 'package:zanimo/constants.dart';

class SubItem extends StatelessWidget {
  const SubItem({
    Key? key,
    required this.size,
    required this.title,
    required this.color,
    required this.value,
  }) : super(key: key);

  final Size size;
  final String title;
  final Color color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.0,
      width: size.width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: kPrimaryColor,
      ),
      child: Column(
        children: [
          Container(
            width: 46.0,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: kPrimaryLightColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
