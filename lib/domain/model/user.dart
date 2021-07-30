class User {
  const User(this.id, this.username);

  final UserId id;
  final UserName username;
}

class UserId {
  const UserId(this.value);
  final String value;
}

class UserName {
  const UserName(this.value);
  final String value;
}
