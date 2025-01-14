import 'package:flutter/material.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/utils/extension.dart';

class OverlayMsgLoader {
  static final OverlayMsgLoader _instance = OverlayMsgLoader._internal();
  factory OverlayMsgLoader() => _instance;

  OverlayMsgLoader._internal();

  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  /// Show the loader without requiring a context
  static void show(String msg) {
    if (_isShowing) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(children: [
            // Semi-transparent background
            Container(color: Colors.transparent),
            // Circular loader in the center
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Text(
                  msg,
                  style: const TextStyle(fontSize: 12, color: whiteColor),
                ),
              ),
            ),
          ]),
        ),
      ),
    );

    final overlayState = NavigatorKey.navigatorKey.currentState?.overlay;
    if (overlayState != null) {
      overlayState.insert(_overlayEntry!);
      _isShowing = true;
    }
  }

  /// Hide the loader
  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isShowing = false;
    }
  }
}
