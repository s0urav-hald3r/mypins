import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/config/images.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/utils/utility_functions.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 70.h),
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Welcome\nto ',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
                TextSpan(
                  text: 'MyPins.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              ]),
            ),
            Image.asset(onboardingOne, width: 105.w)
          ]),
          const Spacer(),
          Image.asset(onboardingOneOne, width: 220.w),
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: 'By tapping “Continue” you agree to MyPins\n',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
              ),
              TextSpan(
                text: 'Terms of Service',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    UtilityFunctions.openUrl(termsOfUseUrl);
                  },
              ),
              TextSpan(
                text: ' and ',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    UtilityFunctions.openUrl(privacyPolicyUrl);
                  },
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
