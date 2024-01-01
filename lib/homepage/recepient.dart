import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class Recepient extends StatefulWidget {
  const Recepient({super.key});

  @override
  State<Recepient> createState() => _RecepientState();
}

class _RecepientState extends State<Recepient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(children: [
          SvgPicture.asset(
            'assets/profile_test.svg',
          )
        ]),
      ),
    );
  }
}
