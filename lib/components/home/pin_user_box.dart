import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/models/pin_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class PinUserBox extends StatelessWidget {
  final PinModel pinModel;
  const PinUserBox({super.key, required this.pinModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(
        25.w,
        0,
        25.w,
        MediaQuery.of(context).viewInsets.bottom,
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
        const Text(
          'Pin Info',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
        ),
        Container(
          width: 40.w,
          height: 40.w,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: pinModel.userImage!,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          'Pinterest User',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: offWhiteColor.withOpacity(.5),
          ),
        ),
        SizedBox(height: 5.h),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.person,
            size: 16,
            color: primaryColor,
          ),
          SizedBox(width: 5.w),
          Text(
            pinModel.userFullName ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: offWhiteColor,
            ),
          ),
        ]),
        SizedBox(height: 10.h),
        Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Title',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: offWhiteColor.withOpacity(.5),
              ),
            ),
            Text(
              pinModel.title ?? 'Title not available for this Pin!',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: offWhiteColor,
              ),
            ),
          ]),
        ]),
        SizedBox(height: 10.h),
        Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Description',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: offWhiteColor.withOpacity(.5),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50.w,
              child: Text(
                pinModel.description ??
                    'Description not available for this Pin!',
                // maxLines: 5,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: offWhiteColor,
                ),
              ),
            ),
          ]),
        ]),
        SizedBox(height: MediaQuery.of(context).padding.bottom)
      ]),
    );
  }
}
