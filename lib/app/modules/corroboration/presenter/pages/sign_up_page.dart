import '../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../widgets/show_password_button.dart';
import '../../../../shared/entities/base_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:easy_market/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:easy_market/app/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
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
              child: BlocListener<SignUpBloc, SignUpState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == BaseStateStatus.success) {
                    getCustomSnackBar(
                      context: context,
                      message: 'Account created successfully',
                      type: SnackBarType.success,
                    );
                    Modular.to.pushReplacementNamed(AppRoutes.lists);
                  } else if (state.status == BaseStateStatus.error) {
                    getCustomSnackBar(
                      context: context,
                      message: state.callbackMessage,
                      type: SnackBarType.error,
                    );
                  }
                },
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (bloc, state) {
                    return state.when(
                      onState: (state) => _BuildScreen(
                        formKey: _formKey,
                        nameKey: _nameKey,
                        confirmPasswordKey: _confirmPasswordKey,
                        emailKey: _emailKey,
                        passwordKey: _passwordKey,
                      ),
                      onLoading: () =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> nameKey;
  final GlobalKey<FormFieldState> emailKey;
  final GlobalKey<FormFieldState> passwordKey;
  final GlobalKey<FormFieldState> confirmPasswordKey;

  const _BuildScreen({
    required this.formKey,
    required this.nameKey,
    required this.emailKey,
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
        _Form(
          formKey: formKey,
          nameKey: nameKey,
          emailKey: emailKey,
          passwordKey: passwordKey,
          confirmPasswordKey: confirmPasswordKey,
        ),
        const SizedBox(height: 25),
        _SignInButton(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Sign Up', style: context.headlineLarge);
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> nameKey;
  final GlobalKey<FormFieldState> emailKey;
  final GlobalKey<FormFieldState> passwordKey;
  final GlobalKey<FormFieldState> confirmPasswordKey;

  const _Form({
    required this.formKey,
    required this.nameKey,
    required this.emailKey,
    required this.passwordKey,
    required this.confirmPasswordKey,
  });

  void signUp(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final bloc = context.read<SignUpBloc>();
      bloc.add(SignUpClickEvent());
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
            _NameField(fieldKey: nameKey),
            const SizedBox(height: 10),
            _EmailField(fieldKey: emailKey),
            const SizedBox(height: 10),
            _PasswordField(fieldKey: passwordKey),
            const SizedBox(height: 10),
            _ConfirmPasswordField(fieldKey: confirmPasswordKey),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => signUp(context),
              size: Size(context.width * 0.7, context.height * 0.067),
              text: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _NameField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    const label = 'Name';

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.name,
      onChanged: (value) => bloc.add(ChangeNameEvent(value)),
      validator: (value) => bloc.validateNameField(fieldValue: value),
    );
  }
}

class _EmailField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _EmailField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignUpBloc>();
    const label = 'Email';

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
    final bloc = context.watch<SignUpBloc>();
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
    final bloc = context.watch<SignUpBloc>();
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

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () => Modular.to.pushReplacementNamed(AppRoutes.signIn),
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}
