import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
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

        return MasonryGridView.builder(
            itemCount: controller.savedPins.length,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (count, index) {
              return InkWell(
                onTap: () {
                  NavigatorKey.push(
                    ShowImageView(imageUrl: controller.savedPins[index]),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:
                      CachedNetworkImage(imageUrl: controller.savedPins[index]),
                ),
              );
            });
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
