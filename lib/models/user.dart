class User
{
  String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}