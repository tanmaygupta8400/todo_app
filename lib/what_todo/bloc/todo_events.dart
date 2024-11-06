import 'package:equatable/equatable.dart';

import '../model/todo_model.dart';

abstract class WhatTodoEvents extends Equatable {}

class GetTodoEvent extends WhatTodoEvents {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateTodoEvent extends WhatTodoEvents {
  final TodoData todoData;

  CreateTodoEvent({required this.todoData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateTodoEvent extends WhatTodoEvents {
  final int index;
  final TodoData todoData;

  UpdateTodoEvent({required this.todoData, required this.index});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteTodoEvent extends WhatTodoEvents {
  final int todoIndex;

  DeleteTodoEvent({required this.todoIndex});

  @override
  List<Object?> get props => throw UnimplementedError();
}
