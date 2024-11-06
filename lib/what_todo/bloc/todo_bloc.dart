import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/what_todo/bloc/todo_events.dart';
import 'package:todo/what_todo/bloc/todo_states.dart';

import '../model/todo_model.dart';
import '../repository/todo_repository.dart';

class TodoBloc extends Bloc<WhatTodoEvents, TodoStates> {
  TodoStates get todoInitialState => WhatTodoInitialState();
  TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(WhatTodoInitialState()) {
    on<GetTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      try {
        WhatTodoModel whatTodoModel = await todoRepository.getTodos();
        emit(GetTodoLoadedState(whatTodoModel: whatTodoModel));
      } catch (e) {
        emit(TodoErrorState(message: e.toString()));
      }
    });

    on<CreateTodoEvent>((event, emit) {
      emit(TodoLoadingState());
      try {
        emit(CreateTodoLoadedState(todoData: event.todoData));
      } catch (e) {
        emit(TodoErrorState(message: e.toString()));
      }
    });

    on<UpdateTodoEvent>((event, emit) {
      emit(TodoLoadingState());
      try {
        emit(UpdateTodoLoadedState(todoData: event.todoData,
        index: event.index));
      } catch (e) {
        emit(TodoErrorState(message: e.toString()));
      }
    });

    on<DeleteTodoEvent>((event, emit) {
      emit(TodoLoadingState());
      try {
        emit(DeleteTodoLoadedState(index: event.todoIndex));
      } catch (e) {
        emit(TodoErrorState(message: e.toString()));
      }
    });
  }

  void showSnackBar(context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text)));
  }
}