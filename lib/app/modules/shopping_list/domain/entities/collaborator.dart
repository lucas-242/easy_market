class Collaborator {
  final String id;
  final String name;
  final String email;
  final bool isAlreadyUser;

  Collaborator({
    this.id = "",
    required this.name,
    required this.email,
    this.isAlreadyUser = true,
  });
}
