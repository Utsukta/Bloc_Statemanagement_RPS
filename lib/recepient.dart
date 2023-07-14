import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
