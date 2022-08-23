import 'package:easy_market/app/core/l10n/generated/l10n.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/widgets/user_circle.dart';
import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:easy_market/app/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:easy_market/app/shared/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/shopping_list_bloc/shopping_list_bloc.dart';

class SharedUsers extends StatelessWidget {
  const SharedUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ShoppingListBloc>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 350,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const ListTile(
                leading: UserCircle(name: 'Lucas Guimarães'),
                title: Text('Lucas Guimarães'),
                subtitle: Text('test@gmail.com'),
              );
            },
          ),
        ),
        Text(AppLocalizations.of(context).addCollaborator,
            style: context.titleMedium),
        const SizedBox(height: 15),
        CustomTextFormField(
          labelText: AppLocalizations.of(context).collaboratorEmail,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: context.width,
          child: CustomElevatedButton(
            onTap: () => null,
            text: AppLocalizations.of(context).add,
          ),
        )
      ],
    );
  }
}
