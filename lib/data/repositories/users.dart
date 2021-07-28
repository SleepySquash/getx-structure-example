import 'dart:convert';

import '../models/user.dart';
import '../providers/graphql.dart';

class UsersRepository {
  const UsersRepository({required this.graphqlProvider});

  final GraphQlProvider graphqlProvider;

  getUsers() async {
    Map<String, dynamic> users =
        json.decode(await graphqlProvider.queryUsers());

    return (users['data'] as List)
        .map((e) => User(username: e['username'], id: e['id']))
        .toList();
  }

  getUser(String id) async {
    var user = json.decode(await graphqlProvider.queryUser(id))['user'];
    return User(username: user['username'], id: user['id']);
  }
}
