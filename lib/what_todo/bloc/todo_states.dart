import 'package:equatable/equatable.dart';

import '../model/todo_model.dart';

abstract class TodoStates extends Equatable {}

class WhatTodoInitialState extends TodoStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class TodoLoadingState extends TodoStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetTodoLoadedState extends TodoStates {
  final WhatTodoModel whatTodoModel;

  GetTodoLoadedState({required this.whatTodoModel});

  @override
  List<Object?> get props => [whatTodoModel];
}

class CreateTodoLoadedState extends TodoStates {
  final TodoData todoData;

  CreateTodoLoadedState({required this.todoData});

  @override
  List<Object?> get props => [todoData];
}

class UpdateTodoLoadedState extends TodoStates {
  final int index;
  final TodoData todoData;

  UpdateTodoLoadedState({required this.todoData, required this.index});

  @override
  List<Object?> get props => [index, todoData];
}

class DeleteTodoLoadedState extends TodoStates {
  final int index;

  DeleteTodoLoadedState({required this.index});

  @override
  List<Object?> get props => [index];
}

class TodoErrorState extends TodoStates {
  final String message;

  TodoErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
