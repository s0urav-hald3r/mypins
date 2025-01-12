import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class ShowImageView extends StatelessWidget {
  final String imageUrl;
  const ShowImageView({super.key, required this.imageUrl});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(children: [
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(imageUrl: imageUrl),
          ),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFF4B4B4B).withOpacity(.25),
              child: SvgPicture.asset(pinIcon),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFF4B4B4B).withOpacity(.25),
              child: SvgPicture.asset(bookmarkIcon),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFF4B4B4B).withOpacity(.25),
              child: SvgPicture.asset(sendIcon),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFF4B4B4B).withOpacity(.25),
              child: SvgPicture.asset(optionsIcon),
            ),
          ]),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ]),
      ),
    );
  }
}
