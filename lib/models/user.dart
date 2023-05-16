class User {
  String _name;
  String _email;

  User(this._name, this._email);

  // factory User.fromDocument

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}
