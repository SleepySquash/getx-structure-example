import 'dart:convert';

import '../domain/repository/user.dart';
import '../domain/model/user.dart';
import '../../provider/graphql.dart';

class UserRepository implements AbstractUserRepository {
  const UserRepository(this.graphqlProvider);

  @override
  final GraphQlProvider graphqlProvider;

  @override
  Future<List<User>?> getUsers(String id) async {
    Map<String, dynamic> users =
        json.decode(await graphqlProvider.queryUsers(id));

    return (users['data'] as List)
        .map((e) => User(UserId(e['id']), UserName(e['username'])))
        .toList();
  }

  @override
  Future<User> getUser(String id) async {
    var user = json.decode(await graphqlProvider.queryUser(id))['user'];
    return User(UserId(user['id']), UserName(user['username']));
  }
}
