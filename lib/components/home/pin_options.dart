import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/components/home/rename_pin_box.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/models/pin_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/utils/overlay_msg_loader.dart';
import 'package:mypins/utils/utility_functions.dart';

class PinOptions extends StatelessWidget {
  final PinModel pin;
  final String? route;
  final bool unsaveOnly;
  final bool fromCollection;
  const PinOptions({
    super.key,
    required this.pin,
    this.route,
    this.unsaveOnly = false,
    this.fromCollection = false,
  });

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
        if (!unsaveOnly)
          InkWell(
            onTap: () {
              NavigatorKey.pop();
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return RenamePinBox(pin: pin);
                  });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(children: [
                const Icon(Icons.edit, size: 20),
                SizedBox(width: 7.5.w),
                const Text(
                  'Rename',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
              ]),
            ),
          ),
        if (!unsaveOnly)
          InkWell(
            onTap: () {
              UtilityFunctions.openUrl(pin.pinterestLink);
              NavigatorKey.pop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(children: [
                const Icon(Icons.language, size: 20),
                SizedBox(width: 7.5.w),
                const Text(
                  'Open on Pinterest',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
              ]),
            ),
          ),
        if (!unsaveOnly)
          InkWell(
            onTap: () async {
              try {
                Clipboard.setData(ClipboardData(text: pin.pinterestLink!));
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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(children: [
                const Icon(Icons.link, size: 20),
                SizedBox(width: 7.5.w),
                const Text(
                  'Copy link',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
              ]),
            ),
          ),
        InkWell(
          onTap: () {
            controller.unSavePin(pin, route);
            if (unsaveOnly) NavigatorKey.pop();

            if (fromCollection) NavigatorKey.pop();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(children: [
              const Icon(Icons.delete, size: 20, color: primaryColor),
              SizedBox(width: 7.5.w),
              const Text(
                'Unsave',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
