import '../../../../core/l10n/generated/l10n.dart';

import '../bloc/reset_password_bloc/reset_password_bloc.dart';
import '../widgets/show_password_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';
import 'package:easy_market/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:easy_market/app/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class ConfirmPasswordResetPage extends StatefulWidget {
  final String code;
  const ConfirmPasswordResetPage({Key? key, required this.code})
      : super(key: key);

  @override
  State<ConfirmPasswordResetPage> createState() =>
      _ConfirmPasswordResetPageState();
}

class _ConfirmPasswordResetPageState extends State<ConfirmPasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    final bloc = context.read<ResetPasswordBloc>();
    bloc.add(ChangeCodeEvent(widget.code));
    super.initState();
  }

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
                    Modular.to
                        .pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
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
                        confirmPasswordKey: _confirmPasswordKey,
                        passwordKey: _passwordKey,
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
  final GlobalKey<FormFieldState> passwordKey;
  final GlobalKey<FormFieldState> confirmPasswordKey;

  const _BuildScreen({
    required this.formKey,
    required this.passwordKey,
    required this.confirmPasswordKey,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        _Header(),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
          child: Text(
            AppLocalizations.of(context).typeNewPassword,
            style: context.bodyMedium,
          ),
        ),
        _Form(
          formKey: formKey,
          passwordKey: passwordKey,
          confirmPasswordKey: confirmPasswordKey,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context).resetPassword,
        style: context.headlineLarge);
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> passwordKey;
  final GlobalKey<FormFieldState> confirmPasswordKey;

  const _Form({
    required this.formKey,
    required this.passwordKey,
    required this.confirmPasswordKey,
  });

  void confirmPasswordReset(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final bloc = context.read<ResetPasswordBloc>();
      bloc.add(ConfirmPasswordResetEvent());
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
            const SizedBox(height: 10),
            _PasswordField(fieldKey: passwordKey),
            const SizedBox(height: 10),
            _ConfirmPasswordField(fieldKey: confirmPasswordKey),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => confirmPasswordReset(context),
              text: AppLocalizations.of(context).confirmPasswordReset,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _PasswordField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ResetPasswordBloc>();
    final label = AppLocalizations.of(context).password;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: bloc.state.showPassword ? false : true,
      suffix: ShowPasswordButton(
        onPressed: () => bloc.add(ChangePasswordVisibilyEvent()),
        showing: bloc.state.showPassword,
      ),
      onChanged: (value) => bloc.add(ChangePasswordEvent(value)),
      validator: (value) => bloc.validatePasswordField(fieldValue: value),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _ConfirmPasswordField({Key? key, required this.fieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ResetPasswordBloc>();
    final label = AppLocalizations.of(context).confirmPassword;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.confirmPassword,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: bloc.state.showConfirmPassword ? false : true,
      suffix: ShowPasswordButton(
        onPressed: () => bloc.add(ChangeConfirmPasswordVisibilyEvent()),
        showing: bloc.state.showConfirmPassword,
      ),
      onChanged: (value) => bloc.add(ChangeConfirmPasswordEvent(value)),
      validator: (value) => bloc.validateConfirmPasswordField(
        fieldValue: value,
        targetValue: bloc.state.password,
      ),
    );
  }
}
