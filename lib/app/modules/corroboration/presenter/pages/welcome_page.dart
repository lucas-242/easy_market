import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../shared/themes/themes.dart';
import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                color: Colors.black,
                height: context.height * 0.38,
                child: const Center(
                  child: Text(
                    'Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              _ActionButtons(),
              // _SocialMediaRow(),
            ],
          ),
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
        const SizedBox(height: 60),
        CustomElevatedButton(
          onTap: () => Modular.to.pushNamed(AppRoutes.signIn),
          text: AppLocalizations.of(context).signIn,
        ),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () => Modular.to.pushNamed(AppRoutes.signUp),
          text: AppLocalizations.of(context).createAccount,
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

// class _SocialMediaRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           onPressed: null,
//           icon: FaIcon(
//             FontAwesomeIcons.google,
//             color: context.colors.primary,
//           ),
//         ),
//         const SizedBox(width: 15),
//         IconButton(
//           onPressed: null,
//           icon: FaIcon(
//             FontAwesomeIcons.facebook,
//             color: context.colors.primary,
//           ),
//         ),
//         const SizedBox(width: 15),
//         IconButton(
//           onPressed: null,
//           icon: FaIcon(
//             FontAwesomeIcons.phone,
//             color: context.colors.primary,
//           ),
//         ),
//       ],
//     );
//   }
// }
