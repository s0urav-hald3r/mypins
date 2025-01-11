import 'package:flutter/material.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/images.dart';
import 'package:mypins/utils/extension.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Image.asset(onboardingTwo),
          Positioned(
            left: 25.w,
            bottom: 95.h,
            child: RichText(
              textAlign: TextAlign.left,
              text: const TextSpan(children: [
                TextSpan(
                  text: 'Create',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
                TextSpan(
                  text: ' Collections\n',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'and',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
                TextSpan(
                  text: ' Organize',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
