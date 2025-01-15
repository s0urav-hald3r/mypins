import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/icons.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class CreateCollectionBox extends StatelessWidget {
  const CreateCollectionBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

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
        const Row(children: [
          Text(
            'Collection Name',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: blackColor,
            ),
          ),
        ]),
        SizedBox(height: 10.h),
        SizedBox(
          height: 50.h,
          child: CupertinoTextField(
            controller: controller.createCollection,
            autofocus: true,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.only(left: 20.w),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4B4B4B),
            ),
            placeholder: 'Enter Collection Name',
            placeholderStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4B4B4B).withOpacity(.5),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
            0,
            25.h,
            0,
            MediaQuery.of(context).padding.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          height: 52.h,
          child: ElevatedButton(
            child: const Text('CREATE COLLECTION'),
            onPressed: () {
              controller.createCollectionModel();
            },
          ),
        ),
      ]),
    );
  }
}
