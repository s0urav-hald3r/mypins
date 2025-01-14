import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/models/collection_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/views/show_image_view.dart';

class OpenCollectionView extends StatelessWidget {
  final CollectionModel collection;
  const OpenCollectionView({super.key, required this.collection});

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
          Column(children: [
            Text(
              collection.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: blackColor,
              ),
            ),
            Text(
              '${collection.pins.length} Saved',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF4B4B4B),
              ),
            ),
          ]),
          SizedBox(height: 25.h),
          MasonryGridView.builder(
              itemCount: collection.pins.length,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (count, index) {
                return InkWell(
                  onTap: () {
                    NavigatorKey.push(
                        ShowImageView(pinModel: collection.pins[index]));
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: collection.pins[index].imageUrl!,
                          ),
                        ),
                        if (collection.pins[index].title != null)
                          Padding(
                            padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0),
                            child: Text(
                              collection.pins[index].title!,
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
        ]),
      ),
    );
  }
}
