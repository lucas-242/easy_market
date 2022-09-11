part of 'collaborator_bloc.dart';

@immutable
abstract class CollaboratorEvent {}

class GetCollaboratorsByEmailsEvent extends CollaboratorEvent {
  final List<String> emails;
  GetCollaboratorsByEmailsEvent(this.emails);
}

class AddCollaboratorEvent extends CollaboratorEvent {
  final String shoppingListId;
  final String email;
  AddCollaboratorEvent(this.shoppingListId, this.email);
}

class ChangeEmailEvent extends CollaboratorEvent {
  final String? email;

  ChangeEmailEvent(this.email);
}
