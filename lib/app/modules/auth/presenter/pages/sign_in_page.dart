import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/modules/auth/presenter/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:market_lists/app/shared/themes/theme_utils.dart';
import 'package:market_lists/app/shared/themes/typography_utils.dart';
import 'package:market_lists/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:market_lists/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:market_lists/app/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (_) => Modular.get<SignInBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: BlocListener<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state is SuccessState) {
                      Modular.to.pushNamedAndRemoveUntil(
                          AppRoutes.lists, (_) => false);
                    } else if (state is ErrorState) {
                      getCustomSnackBar(
                        context: context,
                        message: state.message,
                        type: SnackBarType.error,
                      );
                    }
                  },
                  child: BlocBuilder<SignInBloc, SignInState>(
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
            ],
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
        const TextButton(onPressed: null, child: Text('Forgot password?')),
        const SizedBox(height: 25),
        _SignUpButton(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Sign In', style: context.headlineLarge);
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _Form({required this.formKey});

  void validateForm(BuildContext context) {
    final form = formKey.currentState!;
    if (form.validate()) {
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
            const _EmailField(),
            const SizedBox(height: 10),
            const _PasswordField(),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => validateForm(context),
              size: Size(context.width * 0.7, context.height * 0.067),
              text: 'Sign In',
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignInBloc>();
    const label = 'Email';

    return CustomTextFormField(
      key: const Key('email_formField'),
      labelText: label,
      hintText: 'youremail@email.com',
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
    final bloc = context.watch<SignInBloc>();
    const label = 'Password';

    return CustomTextFormField(
      key: const Key('password_formField'),
      labelText: label,
      initialValue: bloc.state.password,
      onChanged: (value) =>
          context.read<SignInBloc>().add(ChangePasswordEvent(value)),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () => Modular.to.pushReplacementNamed(AppRoutes.signUp),
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}
