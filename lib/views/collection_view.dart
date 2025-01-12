import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/utils/extension.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(children: const [
        FullCollectionView(),
        FullCollectionView(),
      ]),
    );
  }
}

class FullCollectionView extends StatelessWidget {
  const FullCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2024/10/03/10/25/dive-9093321_1280.jpg',
                  fit: BoxFit.cover,
                ),
              );
            }),
      ),
      SizedBox(height: 20.h)
    ]);
  }
}

class InitialCollectionView extends StatelessWidget {
  const InitialCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Empty collection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: blackColor,
            ),
          ),
          const Text(
            '0 Saved',
            style: TextStyle(
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
