import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/controllers/settings_controller.dart';
import 'package:mypins/utils/extension.dart';

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
          _planItem(
            Plan.WEEKLY,
            controller.selectedPlan,
          ),
          SizedBox(height: 15.h),
          _planItem(
            Plan.MONTHLY,
            controller.selectedPlan,
          ),
          SizedBox(height: 15.h),
          _planItem(
            Plan.YEARLY,
            controller.selectedPlan,
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
      case Plan.YEARLY:
        return 'Yearly';
    }
  }

  int getPrice(Plan value) {
    switch (value) {
      case Plan.WEEKLY:
        return 299;
      case Plan.MONTHLY:
        return 599;
      case Plan.YEARLY:
        return 1499;
    }
  }

  int getTenure(Plan value) {
    switch (value) {
      case Plan.WEEKLY:
        return 7;
      case Plan.MONTHLY:
        return 30;
      case Plan.YEARLY:
        return 365;
    }
  }

  Widget _planItem(Plan cValue, Plan gValue) {
    return InkWell(
      onTap: () {
        HomeController.instance.selectedPlan = cValue;
      },
      child: Container(
        height: 70.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: cValue == gValue
                ? primaryColor
                : offWhiteColor.withOpacity(.25),
          ),
        ),
        child:
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
                  '₹${getPrice(cValue)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xFF242424),
                  ),
                ),
              ]),
          Text(
            'Validity ${getTenure(cValue)} Days',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF242424),
            ),
          ),
        ]),
      ),
    );
  }
}
