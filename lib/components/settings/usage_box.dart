import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class UsageBox extends StatelessWidget {
  const UsageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
                      color: offWhiteColor.withOpacity(.5),
                      blurRadius: 5,
                    )
                  ]),
              child: Center(
                child: SvgPicture.asset(crossIcon),
              ),
            ),
          ),
        ),
        const Text(
          '19 Save Left',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
        const Text(
          'You have used 1 out of 20 saves',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: offWhiteColor,
          ),
        ),
        SizedBox(height: 24.h),
        const Row(children: [
          PointCard(point: 'Unlimited Saving'),
          PointCard(point: 'High Quality'),
        ]),
        SizedBox(height: 20.h),
        const Row(children: [
          PointCard(point: 'Batch Saving'),
          PointCard(point: 'No Ads'),
        ]),
        SizedBox(height: 20.h),
        const Row(children: [
          PointCard(point: '100% Secures'),
          PointCard(point: 'All Pins Tasks'),
        ]),
        SizedBox(height: 36.h),
        Container(
          margin: EdgeInsets.fromLTRB(
            25.w,
            0,
            25.w,
            MediaQuery.of(context).padding.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          height: 52.h,
          child: ElevatedButton(
            child: const Text('Get Unlimited Now'),
            onPressed: () {},
          ),
        ),
      ]),
    );
  }
}

class PointCard extends StatelessWidget {
  final String point;
  const PointCard({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Row(children: [
        SizedBox(width: 20.w),
        SvgPicture.asset(checkIcon),
        SizedBox(width: 10.w),
        Text(
          point,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),
        ),
      ]),
    );
  }
}
