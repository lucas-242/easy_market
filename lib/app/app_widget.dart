import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/l10n/generated/l10n.dart';
import 'modules/shopping_list/presenter/bloc/collaborator_bloc/collaborator_bloc.dart';
import 'modules/shopping_list/presenter/bloc/items_bloc/items_bloc.dart';
import 'modules/corroboration/presenter/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'modules/corroboration/presenter/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'modules/corroboration/presenter/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'modules/shopping_list/presenter/bloc/shopping_list_bloc/shopping_list_bloc.dart';
import 'shared/services/stream_subscriptions_cancel.dart';
import 'shared/themes/themes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void dispose() async {
    await Modular.get<StreamSubscriptionsCancel>().cancelSubscriptions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return ThemeProvider(
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
          settings: defaultThemeSettings,
          child: Builder(
            builder: ((context) {
              var appTheme = ThemeProvider.of(context);
              return MultiBlocProvider(
                providers: [
                  BlocProvider<SignInBloc>(
                      create: (_) => Modular.get<SignInBloc>()),
                  BlocProvider<SignUpBloc>(
                      create: (_) => Modular.get<SignUpBloc>()),
                  BlocProvider<ResetPasswordBloc>(
                      create: (_) => Modular.get<ResetPasswordBloc>()),
                  BlocProvider<ShoppingListBloc>(
                    create: (_) => Modular.get<ShoppingListBloc>(),
                  ),
                  BlocProvider<ItemsBloc>(
                    create: (_) => Modular.get<ItemsBloc>(),
                  ),
                  BlocProvider<CollaboratorBloc>(
                    create: (_) => Modular.get<CollaboratorBloc>(),
                  ),
                ],
                child: MaterialApp.router(
                  title: 'Market List',
                  debugShowCheckedModeBanner: false,
                  theme: appTheme.light(defaultThemeSettings.sourceColor),
                  darkTheme: appTheme.dark(defaultThemeSettings.sourceColor),
                  themeMode: defaultThemeSettings.themeMode,
                  routeInformationParser: Modular.routeInformationParser,
                  routerDelegate: Modular.routerDelegate,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.delegate.supportedLocales,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
