part of 'collaborator_bloc.dart';

@immutable
abstract class CollaboratorEvent {}

class ListenCollaboratorsByEmailsEvent extends CollaboratorEvent {
  final List<String> emails;
  ListenCollaboratorsByEmailsEvent(this.emails);
}
