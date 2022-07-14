import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:easy_market/app/modules/auth/presenter/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:easy_market/app/modules/auth/presenter/widgets/show_password_button.dart';
import 'package:easy_market/app/shared/themes/theme_utils.dart';
import 'package:easy_market/app/shared/themes/typography_utils.dart';
import 'package:easy_market/app/shared/utils/base_bloc_state.dart';
import 'package:easy_market/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:easy_market/app/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class ConfirmPasswordResetPage extends StatefulWidget {
  const ConfirmPasswordResetPage({Key? key}) : super(key: key);

  @override
  State<ConfirmPasswordResetPage> createState() =>
      _ConfirmPasswordResetPageState();
}

class _ConfirmPasswordResetPageState extends State<ConfirmPasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

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
                        .pushReplacementNamed(AppRoutes.confirmPasswordReset);
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
                        codeKey: _codeKey,
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
  final GlobalKey<FormFieldState> codeKey;
  final GlobalKey<FormFieldState> passwordKey;
  final GlobalKey<FormFieldState> confirmPasswordKey;

  const _BuildScreen({
    required this.formKey,
    required this.codeKey,
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
            'An email will be send to you with a code to confirm the password reset.',
            style: context.bodyMedium,
          ),
        ),
        _Form(
          formKey: formKey,
          codeKey: codeKey,
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
    return Text('Reset Password', style: context.headlineLarge);
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> codeKey;
  final GlobalKey<FormFieldState> passwordKey;
  final GlobalKey<FormFieldState> confirmPasswordKey;

  const _Form({
    required this.formKey,
    required this.codeKey,
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
            _CodeField(fieldKey: codeKey),
            const SizedBox(height: 10),
            _PasswordField(fieldKey: passwordKey),
            const SizedBox(height: 10),
            _ConfirmPasswordField(fieldKey: confirmPasswordKey),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => confirmPasswordReset(context),
              size: Size(context.width * 0.7, context.height * 0.067),
              text: 'Confirm password reset',
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _CodeField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ResetPasswordBloc>();
    const label = 'Code';

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.code,
      onChanged: (value) => bloc.add(ChangeCodeEvent(value)),
      validator: (value) => bloc.validateCodeField(fieldValue: value),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _PasswordField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ResetPasswordBloc>();
    const label = 'Password';

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
    const label = 'Confirm Password';

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
