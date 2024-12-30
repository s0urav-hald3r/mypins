import 'package:fadingpageview/fadingpageview.dart';
import 'package:flutter/material.dart';
import 'package:mypins/components/onboarding/page_one.dart';
import 'package:mypins/components/onboarding/page_three.dart';
import 'package:mypins/components/onboarding/page_two.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/services/local_storage.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';
import 'package:mypins/views/home_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  FadingPageViewController pageController = FadingPageViewController(0, 3);
  final controller = HomeController.instance;

  DateTime? lastTapTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FadingPageView(
              controller: pageController,
              disableWhileAnimating: true,
              fadeInDuration: const Duration(milliseconds: 250),
              fadeOutDuration: const Duration(milliseconds: 250),
              itemBuilder: (context, itemIndex) {
                return [
                  const PageOne(),
                  const PageTwo(),
                  const PageThree()
                ][itemIndex];
              }),
        ),
        Positioned(
          bottom: 0,
          right: 25.w,
          left: 25.w,
          child: SafeArea(
            top: false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45.h,
              child: ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {
                  final cTime = DateTime.now();
                  if (lastTapTime == null ||
                      cTime.difference(lastTapTime!) >
                          const Duration(milliseconds: 500)) {
                    lastTapTime = cTime;
                    // Your button action here
                    debugPrint("Button tapped");
                  } else {
                    debugPrint("Double tap detected - ignored");
                    return;
                  }

                  if (controller.onboardingIndex < 2) {
                    controller.onboardingIndex++;

                    pageController.next();
                  } else {
                    LocalStorage.addData(isOnboardingDone, true);
                    NavigatorKey.pushReplacement(const HomeView());
                  }
                },
              ),
            ),
          ),
        )
      ]),
    );
  }
}
