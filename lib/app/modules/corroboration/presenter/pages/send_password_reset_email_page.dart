import '../../../../core/l10n/generated/l10n.dart';
import '../bloc/reset_password_bloc/reset_password_bloc.dart';
import '../../../../shared/entities/base_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:easy_market/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:easy_market/app/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class SendPasswordResetEmailPage extends StatefulWidget {
  const SendPasswordResetEmailPage({Key? key}) : super(key: key);

  @override
  State<SendPasswordResetEmailPage> createState() =>
      _SendPasswordResetEmailPageState();
}

class _SendPasswordResetEmailPageState
    extends State<SendPasswordResetEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == BaseStateStatus.success) {
                    Modular.to.pushReplacementNamed(
                        AppRoutes.feedbackPasswordResetEmail);
                  } else if (state.status == BaseStateStatus.error) {
                    getCustomSnackBar(
                      context: context,
                      message: state.callbackMessage,
                      type: SnackBarType.error,
                    );
                  }
                },
                child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                  builder: (bloc, state) {
                    return state.when(
                      onState: (state) => _BuildScreen(
                        formKey: _formKey,
                        emailKey: _emailKey,
                      ),
                      onLoading: () =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> emailKey;

  const _BuildScreen({
    required this.formKey,
    required this.emailKey,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        _Header(),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            AppLocalizations.of(context).sendPasswordInstructions1,
            style: context.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
          child: Text(
            AppLocalizations.of(context).sendPasswordInstructions2,
            style: context.bodyMedium,
          ),
        ),
        _Form(
          formKey: formKey,
          emailKey: emailKey,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).resetPassword,
      style: context.headlineLarge,
    );
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> emailKey;

  const _Form({
    required this.formKey,
    required this.emailKey,
  });

  void sendResetPasswordEmail(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final bloc = context.read<ResetPasswordBloc>();
      bloc.add(SendPasswordResetEmailEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _EmailField(fieldKey: emailKey),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => sendResetPasswordEmail(context),
              text: AppLocalizations.of(context).sendEmail,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _EmailField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ResetPasswordBloc>();
    final label = AppLocalizations.of(context).email;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.email,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => bloc.add(ChangeEmailEvent(value)),
      validator: (value) => bloc.validateEmailField(fieldValue: value),
    );
  }
}
