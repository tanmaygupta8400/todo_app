class WhatTodoModel {
  List<TodoData>? todoList;

  WhatTodoModel({required this.todoList});

  factory WhatTodoModel.fromJson(List json) => WhatTodoModel(
      todoList: List<TodoData>.from(json.map((x) => TodoData.fromJson(x))));
}

class TodoData {
  int todoId;
  String todoName;
  bool todoStatus;

  TodoData({required this.todoId, required this.todoName,required this.todoStatus});

  factory TodoData.fromJson(Map<String, dynamic> json) =>
      TodoData(
          todoId: json["todoId"],
          todoName: json["todoName"],
          todoStatus: json["todoStatus"] ?? false
      );
}
