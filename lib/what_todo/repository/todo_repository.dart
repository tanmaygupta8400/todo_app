import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/todo_model.dart';

abstract class TodoRepository {
  Future<WhatTodoModel> getTodos();
}

class WhatTodoRepository extends TodoRepository {
  @override
  Future<WhatTodoModel> getTodos() async {
    final response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/tanmaygupta8400/response/refs/heads/main/todo2"));
    return WhatTodoModel.fromJson(jsonDecode(response.body));
  }
}
