import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/views/show_image_view.dart';

class OpenCollectionView extends StatelessWidget {
  const OpenCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          const Column(children: [
            Text(
              'Nature Collections',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: blackColor,
              ),
            ),
            Text(
              '7 Saved',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF4B4B4B),
              ),
            ),
          ]),
          SizedBox(height: 25.h),
          Expanded(
            child: MasonryGridView.builder(
                itemCount: imageLists.length,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (count, index) {
                  return InkWell(
                    onTap: () {
                      NavigatorKey.push(
                          ShowImageView(imageUrl: imageLists[index]));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(imageUrl: imageLists[index]),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
