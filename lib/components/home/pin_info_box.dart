import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/models/pin_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/utils/overlay_msg_loader.dart';
import 'package:mypins/utils/utility_functions.dart';

class PinInfoBox extends StatelessWidget {
  final PinModel pinModel;
  const PinInfoBox({super.key, required this.pinModel});

  @override
  Widget build(BuildContext context) {
    debugPrint('pinModel: ${pinModel}');

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
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
              (pinModel.title ?? '').trim().isEmpty
                  ? 'not available...'
                  : pinModel.title!,
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
                (pinModel.description ?? '').trim().isEmpty
                    ? 'not available...'
                    : pinModel.description!,
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
        SizedBox(height: 10.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onTap: () async {
              try {
                Clipboard.setData(ClipboardData(text: pinModel.pinterestLink!));
                NavigatorKey.pop();

                await Future.delayed(const Duration(milliseconds: 250));
                OverlayMsgLoader.show('Link copied');
                Future.delayed(const Duration(milliseconds: 2000), () {
                  OverlayMsgLoader.hide();
                });
              } catch (e) {
                NavigatorKey.pop();

                await Future.delayed(const Duration(milliseconds: 250));
                OverlayMsgLoader.show('Link copied failed');
                Future.delayed(const Duration(milliseconds: 2000), () {
                  OverlayMsgLoader.hide();
                });
              }
            },
            child: Container(
              width: 150.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: offWhiteColor.withOpacity(.25),
              ),
              child: const Center(
                child: Text(
                  'Copy Link',
                  style: TextStyle(
                    fontSize: 13,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              UtilityFunctions.openUrl(pinModel.pinterestLink!);
              NavigatorKey.pop();
            },
            child: Container(
              width: 150.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Open on Pinterest',
                  style: TextStyle(
                    fontSize: 13,
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ]),
        SizedBox(height: MediaQuery.of(context).padding.bottom)
      ]),
    );
  }
}
