class User {
  String email = "";
  String name = "";
  String token = "";

  User({required this.email, required this.name, required this.token});

  @override
  String toString() {
    return 'User{email: $email, name: $name, token: $token}';
  }
}
