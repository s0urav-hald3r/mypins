import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mypins/components/home/pin_options.dart';
import 'package:mypins/components/home/show_collections_list.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/views/premium_view.dart';
import 'package:mypins/views/show_image_view.dart';

class PinSaveView extends StatelessWidget {
  const PinSaveView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        if (controller.savedPins.isEmpty) {
          return const EmptySavedPinView();
        }

        return Column(children: [
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.savedPinsCount}/20 Saves Usage',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      NavigatorKey.push(const PremiumView());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(children: [
                        SvgPicture.asset(
                          premiumIcon,
                          width: 15.w,
                          color: whiteColor,
                        ),
                        SizedBox(width: 5.w),
                        const Text(
                          'Get Unlimited',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: whiteColor,
                          ),
                        ),
                      ]),
                    ),
                  )
                ]),
          ),
          Expanded(
            child: MasonryGridView.builder(
                itemCount: controller.savedPins.length,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                shrinkWrap: true,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (count, index) {
                  return InkWell(
                    onTap: () {
                      NavigatorKey.push(
                        ShowImageView(
                          imageUrl: controller.savedPins[index].imageUrl ??
                              'https://www.huber-online.com/daisy_website_files/_processed_/8/0/csm_no-image_d5c4ab1322.jpg',
                        ),
                      );
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(children: [
                              CachedNetworkImage(
                                imageUrl: controller
                                        .savedPins[index].imageUrl ??
                                    'https://www.huber-online.com/daisy_website_files/_processed_/8/0/csm_no-image_d5c4ab1322.jpg',
                              ),
                              Positioned(
                                bottom: 10.h,
                                left: 10.w,
                                right: 10.w,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return ShowCollectionsList(
                                                  model: controller
                                                      .savedPins[index],
                                                );
                                              });
                                        },
                                        child: Container(
                                          width: 40.w,
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                            color: whiteColor.withOpacity(.75),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              addToCIcon,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.shareImage(
                                              controller.savedPins[index]);
                                        },
                                        child: Container(
                                          width: 40.w,
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                            color: whiteColor.withOpacity(.75),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              sendPinIcon,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return PinOptions(
                                                  pin: controller
                                                      .savedPins[index],
                                                );
                                              });
                                        },
                                        child: Container(
                                          width: 40.w,
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                            color: whiteColor.withOpacity(.75),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              menuIcon,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                              )
                            ]),
                          ),
                          if (controller.savedPins[index].title != null)
                            Padding(
                              padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0),
                              child: Text(
                                controller.savedPins[index].title!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: offWhiteColor,
                                ),
                              ),
                            )
                        ]),
                  );
                }),
          )
        ]);
      }),
    );
  }
}

class EmptySavedPinView extends StatelessWidget {
  const EmptySavedPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
    ]);
  }
}
