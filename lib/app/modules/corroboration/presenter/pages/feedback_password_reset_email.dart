import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/themes/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FeedbackPasswordResetEmail extends StatelessWidget {
  const FeedbackPasswordResetEmail({Key? key}) : super(key: key);

  Future<void> _openEmailApp() async {
    if (Platform.isAndroid) {
      const AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
        flags: [268435456],
      );
      await intent.launch();
    } else if (Platform.isIOS) {
      await launchUrlString("message://");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0, bottom: 35.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: context.height * .15,
                  width: context.width * .3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: context.colors.onPrimary,
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.envelopeOpenText,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context).checkEmail,
                  style: context.titleLarge,
                ),
                const SizedBox(height: 15),
                Text(
                  AppLocalizations.of(context).resetPasswordLinkSent,
                  style: context.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                CustomElevatedButton(
                  onTap: () => _openEmailApp(),
                  text: AppLocalizations.of(context).openEmailApp,
                  width: context.width * 0.4,
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () => Modular.to
                      .pushNamedAndRemoveUntil(AppRoutes.auth, (p0) => false),
                  child: Text(AppLocalizations.of(context).confirmLater),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: AppLocalizations.of(context).didNotReceiveEmail,
              children: [
                TextSpan(
                  text: AppLocalizations.of(context).tryAnotherEmail,
                  style: TextStyle(color: context.colors.onPrimary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Modular.to
                        .pushReplacementNamed(AppRoutes.sendPasswordResetEmail),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
