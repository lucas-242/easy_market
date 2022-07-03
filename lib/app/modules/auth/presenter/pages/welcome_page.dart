import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/shared/themes/theme_utils.dart';
import 'package:market_lists/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              width: context.width * 0.8,
              height: context.height * 0.35,
            ),
            _ActionButtons(),
            _SocialMediaRow(),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () => Modular.to.pushNamed(AppRoutes.signIn),
          size: Size(context.width * 0.7, context.height * 0.067),
          text: 'Sign In',
        ),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () => Modular.to.pushNamed(AppRoutes.signUp),
          size: Size(context.width * 0.7, context.height * 0.067),
          text: 'Create an Account',
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _SocialMediaRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: null,
          icon: FaIcon(
            FontAwesomeIcons.google,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(width: 15),
        IconButton(
          onPressed: null,
          icon: FaIcon(
            FontAwesomeIcons.facebook,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(width: 15),
        IconButton(
          onPressed: null,
          icon: FaIcon(
            FontAwesomeIcons.twitter,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(width: 15),
        IconButton(
          onPressed: null,
          icon: FaIcon(
            FontAwesomeIcons.github,
            color: context.colors.primary,
          ),
        ),
      ],
    );
  }
}
