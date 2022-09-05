part of 'collaborator_bloc.dart';

class CollaboratorState extends BaseBlocState {
  final List<Collaborator> collaborators;

  CollaboratorState({
    List<Collaborator>? collaborators,
    required super.status,
    super.callbackMessage,
  }) : collaborators = collaborators ?? [];

  @override
  CollaboratorState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<Collaborator>? collaborators,
  }) {
    return CollaboratorState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      collaborators: collaborators ?? this.collaborators,
    );
  }

  CollaboratorState successState() {
    return CollaboratorState(
      status: BaseStateStatus.success,
      collaborators: collaborators,
    );
  }
}
