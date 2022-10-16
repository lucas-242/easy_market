import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../shared/entities/base_bloc_state.dart';
import '../../../../shared/themes/themes.dart';
import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_slidable/custom_slidable.dart';
import '../../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../shared/widgets/custom_text_form_field/custom_text_form_field.dart';
import '../../domain/entities/collaborator.dart';
import '../bloc/collaborator_bloc/collaborator_bloc.dart';
import 'collaborator_circle.dart';

class CollaboratorsPanel extends StatelessWidget {
  final _emailKey = GlobalKey<FormFieldState>();
  final String shoppingListId;

  CollaboratorsPanel({Key? key, required this.shoppingListId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollaboratorBloc, CollaboratorState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == BaseStateStatus.error) {
          //TODO: add snackbbar above bottomSheet
          Modular.to.pop();
          getCustomSnackBar(
            context: context,
            message: state.callbackMessage,
            type: SnackBarType.error,
          );
        } else if (state.status == BaseStateStatus.success) {
          Modular.to.pop();
          getCustomSnackBar(
            context: context,
            message: AppLocalizations.of(context).success,
            type: SnackBarType.success,
          );
        }
      },
      child: BlocBuilder<CollaboratorBloc, CollaboratorState>(
        builder: (bloc, state) {
          return state.when(
            onState: (_) => _BuildScreen(
              shoppingListId: shoppingListId,
              emailKey: _emailKey,
            ),
          );
        },
      ),
    );
  }
}

class _BuildScreen extends StatelessWidget {
  final GlobalKey<FormFieldState> emailKey;
  final String shoppingListId;

  const _BuildScreen({
    Key? key,
    required this.shoppingListId,
    required this.emailKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CollaboratorBloc>();

    void onTapDelete(Collaborator collaborator) {
      bloc.add(RemoveCollaboratorEvent(shoppingListId, collaborator.email));
    }

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
              return CustomSlidable(
                leftPanel: false,
                rightPanel: true,
                onRightSlide: () => onTapDelete(collaborator),
                child: ListTile(
                  leading: CollaboratorCircle(collaborator: collaborator),
                  title: Text(collaborator.name),
                  subtitle: Text(collaborator.email),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Text(AppLocalizations.of(context).addCollaborator,
            style: context.titleMedium),
        const SizedBox(height: 15),
        CustomTextFormField(
          textFormKey: emailKey,
          labelText: AppLocalizations.of(context).collaboratorEmail,
          initialValue: bloc.state.collaboratorEmail,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => bloc.add(ChangeEmailEvent(value)),
          validator: (value) => bloc.validateEmailField(fieldValue: value),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: context.width,
          child: CustomElevatedButton(
            onTap: () => bloc.add(AddCollaboratorEvent(
                shoppingListId, bloc.state.collaboratorEmail)),
            text: AppLocalizations.of(context).add,
          ),
        )
      ],
    );
  }
}
