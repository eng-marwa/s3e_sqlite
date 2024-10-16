class User {
  String? name;
  String? phone;

  User._();
  static User? _user; //private nullable reference
  factory User() {
    if (_user == null) {
      _user = User._();
    }
    return _user!;
  }

  @override
  String toString() {
    return '$name, $phone';
  }
}
