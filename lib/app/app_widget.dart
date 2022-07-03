import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/modules/shopping_list/presenter/bloc/shopping_list_bloc.dart';
import 'package:market_lists/app/shared/themes/theme_provider.dart';

import 'shared/themes/theme_settings.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

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
                  BlocProvider<ShoppingListBloc>(
                    create: (_) => Modular.get<ShoppingListBloc>(),
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
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
