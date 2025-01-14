import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/models/pin_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class PinOptions extends StatelessWidget {
  final PinModel pin;
  const PinOptions({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(
        25.w,
        0,
        25.w,
        MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: whiteColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          onTap: () {
            NavigatorKey.pop();
          },
          child: Transform.translate(
            offset: Offset(0, -20.h),
            child: Container(
              width: 40.h,
              height: 40.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: offWhiteColor.withOpacity(.25),
                      blurRadius: 5,
                    )
                  ]),
              child: Center(
                child: SvgPicture.asset(crossIcon),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Row(children: [
            const Icon(Icons.language, size: 20),
            SizedBox(width: 7.5.w),
            const Text(
              'Open on Pinterest',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: blackColor,
              ),
            ),
          ]),
        ),
        SizedBox(height: 20.h),
        InkWell(
          onTap: () {},
          child: Row(children: [
            const Icon(Icons.link, size: 20),
            SizedBox(width: 7.5.w),
            const Text(
              'Copy link',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: blackColor,
              ),
            ),
          ]),
        ),
        SizedBox(height: 20.h),
        InkWell(
          onTap: () {},
          child: Row(children: [
            const Icon(Icons.delete, size: 20, color: primaryColor),
            SizedBox(width: 7.5.w),
            const Text(
              'Unsave',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
