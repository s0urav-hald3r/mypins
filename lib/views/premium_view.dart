import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mypins/components/premium/plan_container.dart';
import 'package:mypins/components/premium/premium_links.dart';
import 'package:mypins/components/settings/usage_box.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/settings_controller.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class PremiumView extends StatelessWidget {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        InkWell(
          onTap: () {
            NavigatorKey.pop();
          },
          child: Container(
            width: 40.h,
            height: 40.h,
            margin: EdgeInsets.only(right: 20.w),
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
        )
      ]),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          SizedBox(height: 30.h),
          Container(
            width: 60.h,
            height: 60.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: secondaryColor,
            ),
            child: Center(
              child: SvgPicture.asset(premiumIcon, color: whiteColor),
            ),
          ),
          SizedBox(height: 6.h),
          const Text(
            'MyPins Pro',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
          ),
          SizedBox(height: 6.h),
          const Text(
            'Unlock all features, Upgrade experience',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: blackColor,
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 40.h,
          //   margin: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 0),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: const Color(0xFF2388FF)),
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   child: Row(children: [
          //     SizedBox(width: 10.w),
          //     SvgPicture.asset(rewardIcon),
          //     SizedBox(width: 10.w),
          //     const Text(
          //       '50 Credit Per Month Free',
          //       style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Color(0xFF2388FF),
          //       ),
          //     ),
          //   ]),
          // ),
          const Spacer(),
          const Row(children: [
            PointCard(point: 'Unlimited Saving'),
            PointCard(point: 'High Quality'),
          ]),
          SizedBox(height: 20.h),
          const Row(children: [
            PointCard(point: 'Batch Saving'),
            PointCard(point: 'No Ads'),
          ]),
          const Spacer(),
          const PlanContainer(),
          Obx(() {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 45.h,
              margin: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: controller.isLoading
                    ? null
                    : () {
                        controller.purchaseProduct();
                      },
                child: Text(controller.isPremium ? 'Subscribed' : 'Continue ≻'),
              ),
            );
          }),
          const PremiumLinks(),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ]),
      ),
    );
  }
}
