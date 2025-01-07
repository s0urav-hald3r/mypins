// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypins/controllers/home_controller.dart';
import 'package:mypins/controllers/settings_controller.dart';
import 'package:mypins/services/local_storage.dart';
import 'package:mypins/views/home_view.dart';
import 'package:mypins/views/onboarding_view.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:mypins/config/colors.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/services/store_config.dart';

// ignore: unused_element
Future<void> _configureSDK() async {
  // Enable debug logs before calling `configure`.
  if (kReleaseMode) {
    await Purchases.setLogLevel(LogLevel.info);
  } else {
    await Purchases.setLogLevel(LogLevel.debug);
  }

  PurchasesConfiguration configuration;

  configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);

  await Purchases.configure(configuration);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize storage
  await GetStorage.init();

  // Configure store for in-app purchase
  if (Platform.isIOS) {
    StoreConfig(
      store: Store.appStore,
      apiKey: appleApiKey,
    );
  }

  // await _configureSDK();

  // Dependency injection
  Get.lazyPut(() => HomeController());
  Get.put(SettingsController());

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: whiteColor,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: whiteColor,
          centerTitle: true,
          titleTextStyle: GoogleFonts.plusJakartaSans(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actionsIconTheme: const IconThemeData(color: primaryColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: whiteColor,
            shadowColor: Colors.transparent,
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      navigatorKey: NavigatorKey.navigatorKey,
      home: LocalStorage.getData(isOnboardingDone, KeyType.BOOL)
          ? const HomeView()
          : const OnboardingView(),
    );
  }
}
