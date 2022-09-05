import '../../../../core/l10n/generated/l10n.dart';
import '../bloc/collaborator_bloc/collaborator_bloc.dart';
import 'collaborator_circle.dart';
import '../../../../shared/themes/themes.dart';
import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollaboratorsPanel extends StatelessWidget {
  const CollaboratorsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CollaboratorBloc>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.height * 0.3,
          child: ListView.builder(
            itemCount: bloc.state.collaborators.length,
            itemBuilder: (context, index) {
              final collaborator = bloc.state.collaborators[index];
              return ListTile(
                leading: CollaboratorCircle(collaborator: collaborator),
                title: Text(collaborator.name),
                subtitle: Text(collaborator.email),
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
