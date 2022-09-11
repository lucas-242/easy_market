import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/add_collaborator_to_list.dart';
import 'package:easy_market/app/shared/validators/form_validator.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../../../shared/entities/base_bloc_state.dart';
import '../../../domain/entities/collaborator.dart';
import '../../../domain/usecases/get_collaborators_by_emails.dart';

part 'collaborator_event.dart';
part 'collaborator_state.dart';

class CollaboratorBloc extends Bloc<CollaboratorEvent, CollaboratorState>
    with FormValidator {
  final GetCollaboratorsByEmails getCollaboratorsByEmailsUsecase;
  final AddCollaboratorToList addCollaboratorUsecase;
  CollaboratorBloc({
    required this.getCollaboratorsByEmailsUsecase,
    required this.addCollaboratorUsecase,
  }) : super(CollaboratorState(status: BaseStateStatus.initial)) {
    on<GetCollaboratorsByEmailsEvent>(_onGetCollaboratorsByEmails);
    on<AddCollaboratorEvent>(_onAddCollaborator);
    on<ChangeEmailEvent>(_onChangeEmail);
  }

  Future<void> _onGetCollaboratorsByEmails(GetCollaboratorsByEmailsEvent event,
      Emitter<CollaboratorState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _getCollaboratorsByEmails(emit, event.emails);
  }

  Future<void> _getCollaboratorsByEmails(
      Emitter<CollaboratorState> emit, List<String> emails) async {
    final result = await getCollaboratorsByEmailsUsecase(emails);
    result.fold(
      (error) async => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) async => emit(state.copyWith(
        status: BaseStateStatus.success,
        collaborators: result,
        collaboratorEmail: '',
      )),
    );
  }

  Future<void> _onAddCollaborator(
      AddCollaboratorEvent event, Emitter<CollaboratorState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _addCollaborator(event, emit);

    if (state.status != BaseStateStatus.error) {
      await _refreshCollaborators(emit, [event.email]);
    }
  }

  Future<void> _addCollaborator(
      AddCollaboratorEvent event, Emitter<CollaboratorState> emit) async {
    final result =
        await addCollaboratorUsecase(event.shoppingListId, event.email);
    result.fold(
        (error) => emit(state.copyWith(
            status: BaseStateStatus.error, callbackMessage: error.message)),
        (result) => null);
  }

  Future<void> _refreshCollaborators(
      Emitter<CollaboratorState> emit, List<String> newEmails) async {
    final emails = state.collaborators.map((e) => e.email).toList()
      ..addAll(newEmails);
    await _getCollaboratorsByEmails(emit, emails);
  }

  void _onChangeEmail(ChangeEmailEvent event, Emitter<CollaboratorState> emit) {
    emit(state.copyWith(collaboratorEmail: event.email));
  }
}
