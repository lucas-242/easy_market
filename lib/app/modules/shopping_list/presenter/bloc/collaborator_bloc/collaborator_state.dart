part of 'collaborator_bloc.dart';

class CollaboratorState extends BaseBlocState {
  final List<Collaborator> collaborators;
  final String collaboratorEmail;

  CollaboratorState({
    List<Collaborator>? collaborators,
    String? collaboratorEmail,
    required super.status,
    super.callbackMessage,
  })  : collaboratorEmail = collaboratorEmail ?? '',
        collaborators = collaborators ?? [];

  @override
  CollaboratorState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<Collaborator>? collaborators,
    String? collaboratorEmail,
  }) {
    return CollaboratorState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      collaborators: collaborators ?? this.collaborators,
      collaboratorEmail: collaboratorEmail ?? this.collaboratorEmail,
    );
  }

  CollaboratorState successState() {
    return CollaboratorState(
      status: BaseStateStatus.success,
      collaborators: collaborators,
    );
  }
}
