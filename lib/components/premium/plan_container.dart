import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/controllers/settings_controller.dart';
import 'package:mypins/utils/extension.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlanContainer extends StatefulWidget {
  const PlanContainer({super.key});

  @override
  State<PlanContainer> createState() => _PlanContainerState();
}

class _PlanContainerState extends State<PlanContainer> {
  final controller = HomeController.instance;
  final settingsController = SettingsController.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      width: MediaQuery.of(context).size.width,
      child: Obx(() {
        return Column(children: [
          Skeletonizer(
            enabled: settingsController.isLoading,
            child: _planItem(
              Plan.MONTHLY,
              controller.selectedPlan,
            ),
          ),
          SizedBox(height: 15.h),
          Skeletonizer(
            enabled: settingsController.isLoading,
            child: _planItem(
              Plan.LIFETIME,
              controller.selectedPlan,
            ),
          ),
          SizedBox(height: 15.h),
          Skeletonizer(
            enabled: settingsController.isLoading,
            child: _planItem(
              Plan.WEEKLY,
              controller.selectedPlan,
            ),
          ),
        ]);
      }),
    );
  }

  String getPlan(Plan value) {
    switch (value) {
      case Plan.WEEKLY:
        return 'Weekly';
      case Plan.MONTHLY:
        return 'Monthly';
      case Plan.LIFETIME:
        return 'Lifetime Membership';
    }
  }

  String getPlanIndentifier(Plan value) {
    switch (value) {
      case Plan.WEEKLY:
        return weeklyPlanIndentifier;
      case Plan.MONTHLY:
        return monthlyPlanIndentifier;
      case Plan.LIFETIME:
        return lifetimePlanIndentifier;
    }
  }

  String getTenure(Plan value) {
    switch (value) {
      case Plan.WEEKLY:
        return 'Validity 7 Days';
      case Plan.MONTHLY:
        return 'Validity 30 Days';
      case Plan.LIFETIME:
        return 'Never expire';
    }
  }

  Widget _planItem(Plan cValue, Plan gValue) {
    StoreProduct? product = settingsController.storeProduct.firstWhereOrNull(
        (element) => element.identifier == getPlanIndentifier(cValue));

    return InkWell(
        onTap: () {
          HomeController.instance.selectedPlan = cValue;
        },
        child: Container(
          height: 70.h,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: cValue == gValue
                  ? primaryColor
                  : offWhiteColor.withOpacity(.25),
            ),
          ),
          child: Stack(clipBehavior: Clip.none, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getPlan(cValue),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF636363),
                      ),
                    ),
                    Text(
                      product?.priceString ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xFF242424),
                      ),
                    ),
                  ]),
              Text(
                getTenure(cValue),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF242424),
                ),
              ),
            ]),
            if (cValue == Plan.LIFETIME)
              Positioned(
                right: 0.w,
                top: -10.h,
                child: Container(
                  height: 20.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Special Offers',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              )
          ]),
        ));
  }
}
