import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

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
                itemCount: 7,
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
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                        imageUrl: [
                      'https://cdn.pixabay.com/photo/2024/10/03/10/25/dive-9093321_1280.jpg',
                      'https://cdn.pixabay.com/photo/2024/10/01/14/04/mother-9088547_1280.jpg',
                      'https://cdn.pixabay.com/photo/2024/12/28/01/27/ai-generated-9295105_1280.jpg',
                      'https://cdn.pixabay.com/photo/2023/12/11/09/36/whisky-8443153_1280.jpg',
                      'https://cdn.pixabay.com/photo/2023/11/08/04/30/girl-8373900_1280.jpg',
                      'https://cdn.pixabay.com/photo/2024/12/13/14/45/real-estate-9265386_1280.jpg',
                      'https://cdn.pixabay.com/photo/2024/05/06/05/57/butterfly-8742569_1280.jpg',
                      // Add more image URLs
                    ][index]),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
