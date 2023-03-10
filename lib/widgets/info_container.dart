import 'package:flutter/material.dart';
import 'package:zanimo/constants.dart';
import 'package:zanimo/widgets/info_item.dart';

class InfoContainer extends StatelessWidget {
  final List<InfoItem> children;

  const InfoContainer({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFCFCFFC).withOpacity(0.15),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
