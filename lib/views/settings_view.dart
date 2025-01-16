import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/components/settings/request_feature_box.dart';
import 'package:mypins/components/settings/usage_box.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/views/premium_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        leadingWidth: 64.w,
        leading: InkWell(
          onTap: () {
            NavigatorKey.pop();
          },
          child: Container(
            width: 44.w,
            height: 44.w,
            margin: EdgeInsets.only(left: 20.w),
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(leftArrowIcon),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20.h),
          Text(
            'App Features'.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: offWhiteColor,
            ),
          ),
          SizedBox(height: 6.h),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const UsageBox();
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 13.h),
              child: Row(children: [
                SvgPicture.asset(saveIcon),
                SizedBox(width: 10.w),
                const Text(
                  'Save Usage',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                ),
                const Spacer(),
                Text(
                  '${controller.savedPinsCount}/20 Saves Usage',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ]),
            ),
          ),
          const Divider(color: Color(0xFFEAEAEA), height: 1),
          // MenuItem(icon: widgetIcon, title: 'Widget', callBack: () {}),
          // const Divider(color: Color(0xFFEAEAEA), height: 1),
          MenuItem(icon: hiwIcon, title: 'How it Works', callBack: () {}),
          const Divider(color: Color(0xFFEAEAEA), height: 1),
          MenuItem(
              icon: restoreIcon, title: 'Restore Purchase', callBack: () {}),
          SizedBox(height: 20.h),
          Text(
            'Write Us'.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: offWhiteColor,
            ),
          ),
          SizedBox(height: 6.h),
          // MenuItem(
          //     icon: telegramIcon, title: 'Telegram Channel', callBack: () {}),
          // const Divider(color: Color(0xFFEAEAEA), height: 1),
          MenuItem(
              icon: requestIcon,
              title: 'Request a Feature',
              callBack: () {
                showModalBottomSheet(
                    context: context,
                    isDismissible: false,
                    isScrollControlled: true,
                    builder: (context) {
                      return const RequestFeatureBox();
                    });
              }),
          const Divider(color: Color(0xFFEAEAEA), height: 1),
          MenuItem(icon: reviewIcon, title: 'Write Review', callBack: () {}),
          const Divider(color: Color(0xFFEAEAEA), height: 1),
          MenuItem(icon: shareIcon, title: 'Share App', callBack: () {}),
          SizedBox(height: 20.h),
          Text(
            'About Us'.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: offWhiteColor,
            ),
          ),
          SizedBox(height: 6.h),
          MenuItem(icon: privacyIcon, title: 'Privacy Policy', callBack: () {}),
          const Divider(color: Color(0xFFEAEAEA), height: 1),
          MenuItem(icon: termsIcon, title: 'Terms of Service', callBack: () {}),
          const Spacer(),
          InkWell(
            onTap: () {
              NavigatorKey.push(const PremiumView());
            },
            child: Container(
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: secondaryColor,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40.h,
                      height: 40.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(premiumIcon),
                      ),
                    ),
                    const Text(
                      'GO Premium',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(width: 40.h, height: 40.h),
                  ]),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ]),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function callBack;
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callBack();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 13.h),
        child: Row(children: [
          SvgPicture.asset(icon),
          SizedBox(width: 10.w),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: blackColor,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(rightArrowIcon)
        ]),
      ),
    );
  }
}
