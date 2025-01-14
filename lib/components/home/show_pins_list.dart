import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class ShowPinsList extends StatelessWidget {
  final String collectionTag;
  const ShowPinsList({super.key, required this.collectionTag});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Obx(() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: whiteColor,
        ),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: 120.w,
              height: 30.h,
              margin: EdgeInsets.fromLTRB(0, 10.h, 20.w, 10.h),
              child: ElevatedButton(
                onPressed: () {
                  controller.selectedPins.isNotEmpty
                      ? controller.addPinsToCollection(collectionTag)
                      : NavigatorKey.pop();
                },
                child: Text(
                  controller.selectedPins.isNotEmpty
                      ? 'Select(${controller.selectedPins.length})'
                      : 'Close',
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ]),
          Expanded(
            child: MasonryGridView.builder(
                itemCount: controller.savedPins.length,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                shrinkWrap: true,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (count, index) {
                  return InkWell(
                    onTap: () {
                      controller.removePin(controller.savedPins[index]);
                    },
                    onLongPress: () {
                      controller.selectPin(controller.savedPins[index]);
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
                              if (controller.savedPins[index].isSelected ??
                                  false)
                                Positioned(
                                    right: 10.w,
                                    top: 10.h,
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                    ))
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
          ),
        ]),
      );
    });
  }
}
