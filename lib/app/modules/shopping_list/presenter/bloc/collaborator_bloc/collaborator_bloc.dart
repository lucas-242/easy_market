import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/errors/errors.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../../../shared/entities/base_bloc_state.dart';
import '../../../domain/entities/collaborator.dart';
import '../../../domain/usecases/listen_collaborators_by_emails.dart';

part 'collaborator_event.dart';
part 'collaborator_state.dart';

class CollaboratorBloc extends Bloc<CollaboratorEvent, CollaboratorState> {
  final ListenCollaboratorsByEmails listenCollaboratorsByEmailsUsecase;
  CollaboratorBloc({
    required this.listenCollaboratorsByEmailsUsecase,
  }) : super(CollaboratorState(status: BaseStateStatus.initial)) {
    on<ListenCollaboratorsByEmailsEvent>(_onListenCollaboratorsByEmails);
  }

  Future<void> _onListenCollaboratorsByEmails(
      ListenCollaboratorsByEmailsEvent event,
      Emitter<CollaboratorState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _listenCollaboratorsByEmails(event, emit);
  }

  Future<void> _listenCollaboratorsByEmails(
      ListenCollaboratorsByEmailsEvent event,
      Emitter<CollaboratorState> emit) async {
    var result = listenCollaboratorsByEmailsUsecase(event.emails);

    await emit.forEach(
      result,
      onData: (Either<Failure, List<Collaborator>> data) =>
          data.fold<CollaboratorState>(
              (failure) => state.copyWith(
                  status: BaseStateStatus.error,
                  callbackMessage: failure.message),
              (collaborators) => state.copyWith(
                  status: BaseStateStatus.success,
                  collaborators: collaborators)),
    );
  }
}
