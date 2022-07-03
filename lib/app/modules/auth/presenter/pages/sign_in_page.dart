import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/modules/auth/presenter/bloc/auth_bloc.dart';
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
    // final bloc = context.read<AuthBloc>();

    return BlocProvider<AuthBloc>(
      create: (_) => Modular.get<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocListener<AuthBloc, AuthState>(
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
                      child: _BuildScreen(formKey: _formKey),
                    ),
                  ],
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
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<AuthBloc, AuthState>(builder: (bloc, state) {
              return state.when(
                onState: (state) => _Form(formKey: formKey),
                onLoading: () =>
                    const Center(child: CircularProgressIndicator()),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _Form({required this.formKey});

  void validateForm(BuildContext context) {
    final form = formKey.currentState!;
    if (form.validate()) {
      final bloc = context.read<AuthBloc>();
      bloc.add(SignInWithEmailEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          children: [
            const _EmailField(),
            const _PasswordField(),
            CustomElevatedButton(
              text: 'Sign in',
              onTap: () => validateForm(context),
            ),
            Row(children: const [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text("OR"),
              ),
              Expanded(child: Divider()),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                IconButton(
                    onPressed: null, icon: FaIcon(FontAwesomeIcons.google)),
                IconButton(
                    onPressed: null, icon: FaIcon(FontAwesomeIcons.facebook)),
                IconButton(
                    onPressed: null, icon: FaIcon(FontAwesomeIcons.twitter)),
                IconButton(
                    onPressed: null, icon: FaIcon(FontAwesomeIcons.github)),
              ],
            )
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
    final bloc = context.watch<AuthBloc>();
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
    final bloc = context.watch<AuthBloc>();
    const label = 'Password';

    return CustomTextFormField(
      key: const Key('password_formField'),
      labelText: label,
      initialValue: bloc.state.password,
      onChanged: (value) =>
          context.read<AuthBloc>().add(ChangePasswordEvent(value)),
    );
  }
}
