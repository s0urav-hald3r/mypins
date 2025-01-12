import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/models/collection_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/views/open_collection_view.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        if (controller.collections.isEmpty) {
          return const EmptyCollectionView();
        }

        return ListView(
            children: controller.collections.map((collection) {
          if (collection.images.isEmpty) {
            return InitialCollectionView(model: collection);
          }

          return const FullCollectionView();
        }).toList());
      }),
    );
  }
}

class FullCollectionView extends StatelessWidget {
  const FullCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'Nature Collections',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
                const Text(
                  '7 Saved',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
                SizedBox(height: 15.h),
              ]),
              Container(
                width: 40.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(child: SvgPicture.asset(menuIcon)),
              )
            ]),
      ),
      SizedBox(
        height: 100.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20.w),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  NavigatorKey.push(const OpenCollectionView());
                },
                child: Container(
                  width: 80.w,
                  height: 100.h,
                  margin: EdgeInsets.only(right: 7.5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://cdn.pixabay.com/photo/2024/10/03/10/25/dive-9093321_1280.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
      ),
      SizedBox(height: 20.h)
    ]);
  }
}

class InitialCollectionView extends StatelessWidget {
  final CollectionModel model;
  const InitialCollectionView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            model.name ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: blackColor,
            ),
          ),
          Text(
            '${model.images.length} Saved',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF4B4B4B),
            ),
          ),
          SizedBox(height: 15.h),
        ]),
      ),
      SizedBox(
        height: 100.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20.w),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                width: 80.w,
                height: 100.h,
                margin: EdgeInsets.only(right: 7.5.w),
                decoration: BoxDecoration(
                  color: index == 0 ? primaryColor : const Color(0xFFDFDEE3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: index == 0
                    ? Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(addIcon),
                              SizedBox(height: 10.h),
                              const Text(
                                'Add\nCollection',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: whiteColor,
                                ),
                              )
                            ]),
                      )
                    : const SizedBox.shrink(),
              );
            }),
      ),
      SizedBox(height: 20.h)
    ]);
  }
}

class EmptyCollectionView extends StatelessWidget {
  const EmptyCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Spacer(),
      SvgPicture.asset(noItemsIcon),
      SizedBox(height: 20.h),
      Text(
        'No Collections Created',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: primaryColor.withOpacity(.5),
        ),
      ),
      SizedBox(height: 5.h),
      const Text(
        'You didn’t create any collection yet,\nCreate your first collection.',
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
