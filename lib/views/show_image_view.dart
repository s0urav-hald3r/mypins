import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/components/home/pin_options.dart';
import 'package:mypins/components/home/pin_info_box.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/models/pin_model.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class ShowImageView extends StatefulWidget {
  final PinModel pinModel;
  final String route;
  const ShowImageView({super.key, required this.pinModel, required this.route});

  @override
  State<ShowImageView> createState() => _ShowImageViewState();
}

class _ShowImageViewState extends State<ShowImageView> {
  final controller = HomeController.instance;
  bool isPinned = false;

  @override
  void initState() {
    super.initState();
    isPinned = widget.pinModel.isPinned ?? false;
  }

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
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: CachedNetworkImage(imageUrl: widget.pinModel.imageUrl!),
            ),
          ),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
              onTap: () {
                controller.togglePinStatus(widget.pinModel, widget.route);

                setState(() {
                  isPinned = !isPinned;
                });
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: isPinned
                    ? primaryColor
                    : const Color(0xFF4B4B4B).withOpacity(.25),
                child: SvgPicture.asset(pinIcon),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return PinOptions(
                        pin: widget.pinModel,
                        unsaveOnly: true,
                        fromCollection: true,
                      );
                    });
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF4B4B4B).withOpacity(.25),
                child: SvgPicture.asset(bookmarkIcon),
              ),
            ),
            InkWell(
              onTap: () {
                controller.shareImage(widget.pinModel);
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF4B4B4B).withOpacity(.25),
                child: SvgPicture.asset(sendIcon),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return PinInfoBox(pinModel: widget.pinModel);
                    });
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF4B4B4B).withOpacity(.25),
                child: SvgPicture.asset(optionsIcon),
              ),
            ),
          ]),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ]),
      ),
    );
  }
}
