import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/components/home/create_collection_box.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/models/pin_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class ShowCollectionsList extends StatelessWidget {
  final PinModel model;
  const ShowCollectionsList({super.key, required this.model});

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
        controller.collections.isEmpty
            ? InkWell(
                onTap: () {
                  NavigatorKey.pop();

                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const CreateCollectionBox();
                      });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(children: [
                    const Icon(Icons.add, size: 20),
                    SizedBox(width: 7.5.w),
                    const Text(
                      'Create collection',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
                  ]),
                ),
              )
            : Column(
                children: controller.collections.map((ele) {
                int index = ele.pins
                    .indexWhere((ele) => ele.imageUrl == model.imageUrl);

                return InkWell(
                  onTap: () {
                    if (index == -1) {
                      controller.addPinsToCollection(ele.name!, pin: model);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(children: [
                      SvgPicture.asset(collectionsIcon),
                      SizedBox(width: 7.5.w),
                      Text(
                        ele.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: index == -1
                              ? blackColor
                              : blackColor.withOpacity(.5),
                        ),
                      ),
                    ]),
                  ),
                );
              }).toList()),
      ]),
    );
  }
}
