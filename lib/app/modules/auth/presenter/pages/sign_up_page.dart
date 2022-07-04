import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/modules/auth/presenter/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:market_lists/app/shared/themes/theme_utils.dart';
import 'package:market_lists/app/shared/themes/typography_utils.dart';
import 'package:market_lists/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:market_lists/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:market_lists/app/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (_) => Modular.get<SignUpBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<SignUpBloc, SignUpState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == SignUpStatus.success) {
                  Modular.to.pushReplacementNamed(AppRoutes.signIn);
                } else if (state.status == SignUpStatus.error) {
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
                    onState: (state) => _BuildScreen(formKey: _formKey),
                    onLoading: () =>
                        const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _BuildScreen({required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        _Header(),
        const SizedBox(height: 25),
        _Form(formKey: formKey),
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

  const _Form({required this.formKey});

  void validateForm(BuildContext context) {
    final form = formKey.currentState!;
    if (form.validate()) {
      final bloc = context.read<SignUpBloc>();
      bloc.add(SignUp());
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
            const _NameField(),
            const SizedBox(height: 10),
            const _EmailField(),
            const SizedBox(height: 10),
            const _PasswordField(),
            const SizedBox(height: 10),
            const _ConfirmPasswordField(),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => validateForm(context),
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
  const _NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignUpBloc>();
    const label = 'Name';

    return CustomTextFormField(
      key: const Key('name_formField'),
      labelText: label,
      initialValue: bloc.state.email,
      onChanged: (value) => bloc.add(ChangeEmailEvent(value)),
      validator: (value) => bloc.validateFieldIsEmpty(value, fieldName: label),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignUpBloc>();
    const label = 'Email';

    return CustomTextFormField(
      key: const Key('email_formField'),
      labelText: label,
      initialValue: bloc.state.email,
      onChanged: (value) => bloc.add(ChangeEmailEvent(value)),
      validator: (value) => bloc.validateFieldIsEmpty(value, fieldName: label),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignUpBloc>();
    const label = 'Password';

    return CustomTextFormField(
      key: const Key('password_formField'),
      labelText: label,
      initialValue: bloc.state.password,
      onChanged: (value) =>
          context.read<SignUpBloc>().add(ChangePasswordEvent(value)),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignUpBloc>();
    const label = 'Confirm Password';

    return CustomTextFormField(
      key: const Key('confirmPassword_formField'),
      labelText: label,
      initialValue: bloc.state.password,
      onChanged: (value) =>
          context.read<SignUpBloc>().add(ChangePasswordEvent(value)),
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
