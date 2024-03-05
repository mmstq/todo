// import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:todo/gen/colors.gen.dart';

/*Widget dottedLine({double vPadding = 16, double hPadding = 0}) => Padding(
      padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
      child: const DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 2.0,
        dashLength: 2.0,
        dashGapLength: 4.0,
        dashRadius: 5,
        dashGapRadius: 5,
        dashColor: ColorName.gray11,
      ),
    );*/


List<BoxShadow> get appBarShadow => [
      const BoxShadow(
        color: ColorName.gray10,
        blurRadius: 8,
        offset: Offset(-1, -1), // Shadow position
      )
    ];

Widget get spacer => const Spacer();

Widget get vPad32 => const SizedBox(height: 32);

Widget get vPad28 => const SizedBox(height: 28);

Widget get vPad24 => const SizedBox(height: 24);

Widget get vPad20 => const SizedBox(height: 20);

Widget get vPad16 => const SizedBox(height: 16);

Widget get vPad12 => const SizedBox(height: 12);

Widget get vPad8 => const SizedBox(height: 8);

Widget get vPad4 => const SizedBox(height: 4);

Widget get hPad32 => const SizedBox(width: 32);

Widget get hPad28 => const SizedBox(width: 28);

Widget get hPad24 => const SizedBox(width: 24);

Widget get hPad20 => const SizedBox(width: 20);

Widget get hPad16 => const SizedBox(width: 16);

Widget get hPad12 => const SizedBox(width: 12);

Widget get hPad8 => const SizedBox(width: 8);

Widget get hPad4 => const SizedBox(width: 4);
