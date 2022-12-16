import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:zanimo/Screens/Profile/profile_screen.dart';
import 'package:zanimo/constants.dart';
import 'package:zanimo/screen/home/widgets/sub_item.dart';
import 'package:zanimo/screen/home/widgets/subscription_item.dart';
import 'package:zanimo/screen/home/widgets/subscription_item_date.dart';
import 'package:zanimo/screen/subscription_info/subscription_info_screen.dart';
import 'dart:math' as math;

import 'package:zanimo/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          CustomPaint(
            foregroundPainter: _RadialGaugePainter(),
            child: Container(
              width: size.width,
              height: size.height * 0.52,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.16),
                  Text(
                    '1234',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Nombre de pas de votre toutou aujourd\'hui',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: kPrimaryLightColor, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: 120.0,
                    height: 32.0,
                    child: CustomButton(
                      onTap: () {},
                      mainColor: Colors.white.withOpacity(0.10),
                      child: Text(
                        'Chien 1',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubItem(
                        size: size,
                        color: kPrimaryLightColor,
                        title: 'Alertes',
                        value: '12',
                      ),
                      const SizedBox(width: 8.0),
                      SubItem(
                        size: size,
                        color: kPrimaryLightColor,
                        title: 'Position',
                        value: 'Imt Atlantique',
                      ),
                      const SizedBox(width: 8.0),
                      SubItem(
                        size: size,
                        color: kPrimaryLightColor,
                        title: 'Distance - repère',
                        value: '500 m',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 21.0),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9.0,
                      vertical: 7.0,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: TabBar(
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      indicator: BoxDecoration(
                        color: kPrimaryLightColor.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      tabs: [
                        Container(
                          height: 36.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 23.0,
                            vertical: 10.0,
                          ),
                          child: Text(
                            'Options',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Container(
                          height: 36.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 23.0,
                            vertical: 10.0,
                          ),
                          child: Text(
                            'Colliers',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TabBarView(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            children: [
                              SubscriptionItem(
                                  trailingWidget: SvgPicture.asset(
                                    'assets/icons/arrow_medium.svg',
                                    width: 40.0,
                                  ),
                                  title: 'Historique de déplacement',
                                  onTap: () => {}),
                              SubscriptionItem(
                                trailingWidget: SvgPicture.asset(
                                  'assets/icons/add_circle.svg',
                                  width: 40.0,
                                ),
                                title: 'Modifier collier',
                              ),
                              SubscriptionItem(
                                trailingWidget: SvgPicture.asset(
                                  'assets/icons/Back.svg',
                                  width: 40.0,
                                ),
                                title: 'Supprimer collier',
                              ),
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            children: const [
                              SubscriptionItem(
                                trailingWidget: SubscriptionItemDate(
                                  day: 25,
                                  month: 'Jun',
                                ),
                                title: 'Ajouter collier',
                              ),
                              SubscriptionItem(
                                trailingWidget: SubscriptionItemDate(
                                  day: 25,
                                  month: 'Jun',
                                ),
                                title: 'Bigi',
                              ),
                              SubscriptionItem(
                                trailingWidget: SubscriptionItemDate(
                                  day: 23,
                                  month: 'Jun',
                                ),
                                title: 'Skini',
                              ),
                              SubscriptionItem(
                                trailingWidget: SubscriptionItemDate(
                                  day: 18,
                                  month: 'Jun',
                                ),
                                title: 'Qaswa',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadialGaugePainter extends CustomPainter {
  // Method to convert degree to radians
  double degToRad(num deg) => deg * (math.pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = kPrimaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final fillLinePaint = Paint()
      ..color = kPrimaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.7;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      degToRad(135.0),
      degToRad(270.0),
      false,
      linePaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      degToRad(135.0),
      degToRad(220.0),
      false,
      fillLinePaint,
    );
  }

  @override
  bool shouldRepaint(_RadialGaugePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_RadialGaugePainter oldDelegate) => false;
}
