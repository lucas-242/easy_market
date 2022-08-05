import '../../../../core/l10n/generated/l10n.dart';
import '../bloc/sign_in_bloc/sign_in_bloc.dart';
import '../widgets/show_password_button.dart';
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

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocListener<SignInBloc, SignInState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == BaseStateStatus.success) {
                    Modular.to
                        .pushNamedAndRemoveUntil(AppRoutes.lists, (_) => false);
                  } else if (state.status == BaseStateStatus.error) {
                    getCustomSnackBar(
                      context: context,
                      message: state.callbackMessage,
                      type: SnackBarType.error,
                    );
                  }
                },
                child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (bloc, state) {
                    return state.when(
                      onState: (state) => _BuildScreen(
                        formKey: _formKey,
                        emailKey: _emailKey,
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
  final GlobalKey<FormFieldState> emailKey;
  final GlobalKey<FormFieldState> passwordKey;

  const _BuildScreen(
      {required this.formKey,
      required this.emailKey,
      required this.passwordKey});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        _Header(),
        const SizedBox(height: 25),
        _Form(
          formKey: formKey,
          emailKey: emailKey,
          passwordKey: passwordKey,
        ),
        _ForgotPasswordButton(),
        const SizedBox(height: 25),
        _SignUpButton(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context).signIn,
        style: context.headlineLarge);
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> emailKey;
  final GlobalKey<FormFieldState> passwordKey;

  const _Form(
      {required this.formKey,
      required this.emailKey,
      required this.passwordKey});

  void signIn(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final bloc = context.read<SignInBloc>();
      bloc.add(SignInWithEmailEvent());
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
            const SizedBox(height: 10),
            _PasswordField(fieldKey: passwordKey),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => signIn(context),
              text: AppLocalizations.of(context).signIn,
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
    final bloc = context.watch<SignInBloc>();
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

class _PasswordField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _PasswordField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignInBloc>();
    final label = AppLocalizations.of(context).password;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.password,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: bloc.state.showPassword ? false : true,
      suffix: ShowPasswordButton(
        onPressed: () => bloc.add(ChangePasswordVisibilyEvent()),
        showing: bloc.state.showPassword,
      ),
      onChanged: (value) =>
          context.read<SignInBloc>().add(ChangePasswordEvent(value)),
      validator: (value) => bloc.validatePasswordField(fieldValue: value),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Modular.to.pushNamed(AppRoutes.sendPasswordResetEmail),
      child: Text(AppLocalizations.of(context).forgetPassword),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).dontHaveAccount),
        TextButton(
          onPressed: () => Modular.to.pushReplacementNamed(AppRoutes.signUp),
          child: Text(AppLocalizations.of(context).signUp),
        ),
      ],
    );
  }
}
