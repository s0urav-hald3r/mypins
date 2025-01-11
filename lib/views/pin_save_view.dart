import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/utils/extension.dart';

class PinSaveView extends StatelessWidget {
  const PinSaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        const Spacer(),
        SvgPicture.asset(noItemsIcon),
        SizedBox(height: 20.h),
        Text(
          'Nothing Saved',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: primaryColor.withOpacity(.5),
          ),
        ),
        SizedBox(height: 5.h),
        const Text(
          'You haven’t saved any pins yet,\nSave your first pin',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF4B4B4B),
          ),
        ),
        const Spacer(),
        Transform.translate(
          offset: Offset(-75.w, -25.h),
          child: SvgPicture.asset(roundedArrowIcon),
        )
      ]),
    );
  }
}
