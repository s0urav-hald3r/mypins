import 'package:flutter/material.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/controllers/settings_controller.dart';
import 'package:mypins/utils/utility_functions.dart';

class PremiumLinks extends StatelessWidget {
  const PremiumLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap: () {
          SettingsController.instance.restorePurchases();
        },
        child: const Text(
          'Restore Purchases',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF575757),
          ),
        ),
      ),
      const Text(
        ' | ',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color(0xFF575757),
        ),
      ),
      InkWell(
        onTap: () {
          UtilityFunctions.openUrl(termsOfUseUrl);
        },
        child: const Text(
          'Terms of Use',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF575757),
          ),
        ),
      ),
      const Text(
        ' | ',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color(0xFF575757),
        ),
      ),
      InkWell(
        onTap: () {
          UtilityFunctions.openUrl(privacyPolicyUrl);
        },
        child: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF575757),
          ),
        ),
      ),
    ]);
  }
}
