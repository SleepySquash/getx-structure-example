import 'dart:convert';

import '../model/user.dart';
import '../../provider/graphql.dart';

class AbstractUserRepository {
  const AbstractUserRepository({required this.graphqlProvider});
  final GraphQlProvider graphqlProvider;

  Future<List<User>?> getUsers(String id) async {}
  Future<User> getUser(String id) async =>
      User(UserId(id), const UserName('username'));
}
