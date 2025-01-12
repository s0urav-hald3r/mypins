import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mypins/components/home/create_collection_box.dart';
import 'package:mypins/components/home/pin_save_box.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/views/collection_view.dart';
import 'package:mypins/views/pin_save_view.dart';
import 'package:mypins/views/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('MyPins'),
          actions: [
            InkWell(
              onTap: () {
                NavigatorKey.push(const SettingsView());
              },
              child: SvgPicture.asset(settingsIcon),
            ),
            SizedBox(width: 20.w),
          ],
        ),
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [PinSaveView(), CollectionView()],
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const [
                    PinSaveBox(),
                    CreateCollectionBox()
                  ][controller.homeIndex];
                });
          },
          backgroundColor: primaryColor,
          child: SvgPicture.asset(
            [downloadIcon, addIcon][controller.homeIndex],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          height: 70.h,
          color: whiteColor,
          notchMargin: 5,
          elevation: 10,
          shape: const CircularNotchedRectangle(),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _navItem(0, pinSaveIcon, 'Pin Save', () {
              controller.homeIndex = 0;
              controller.pageController.jumpToPage(0);
            }),
            _navItem(1, collectionsIcon, 'Collections', () {
              controller.homeIndex = 1;
              controller.pageController.jumpToPage(1);
            }),
          ]),
        ),
      );
    });
  }

  Widget _navItem(int index, String icon, String title, Function callBack) {
    return InkWell(
      onTap: () {
        callBack();
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          icon,
          color: HomeController.instance.homeIndex == index
              ? primaryColor
              : offWhiteColor,
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: HomeController.instance.homeIndex == index
                ? primaryColor
                : offWhiteColor,
          ),
        )
      ]),
    );
  }
}
