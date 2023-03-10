import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanimo/constants.dart';

class SubscriptionItem extends StatelessWidget {
  final Widget trailingWidget;
  final String title;
  final void Function()? onTap;

  const SubscriptionItem({
    Key? key,
    required this.trailingWidget,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 1.0,
            color: kPrimaryColor,
          ),
        ),
        child: Row(
          children: [
            trailingWidget,
            const SizedBox(width: 15.0),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
