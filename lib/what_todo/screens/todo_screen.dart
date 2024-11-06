import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/what_todo/screens/widgets/create_update_dialog.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_events.dart';
import '../bloc/todo_states.dart';
import '../model/todo_model.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TodoBloc todoBloc = BlocProvider.of(context);
    todoBloc.add(GetTodoEvent());
    List<TodoData> whatTodoList = [];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ToDO App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                  value: todoBloc,
                  child: CreateUpdateDialog(
                    isUpdate: false,
                    index: whatTodoList.length + 1,
                  )));
        },
      ),
      body: SafeArea(
          child: BlocConsumer<TodoBloc, TodoStates>(
        listener: (BuildContext context, TodoStates state) {
          if (state is GetTodoLoadedState) {
            whatTodoList = state.whatTodoModel.todoList ?? [];
          }
          if (state is CreateTodoLoadedState) {
            Navigator.pop(context);
            whatTodoList.add(state.todoData);
            todoBloc.showSnackBar(context, "Added Successfully");
          }
          if (state is UpdateTodoLoadedState) {
            Navigator.pop(context);
            whatTodoList[state.index] = state.todoData;
            todoBloc.showSnackBar(context, "Updated Successfully");
          }
          if (state is DeleteTodoLoadedState) {
            whatTodoList.removeAt(state.index);
            todoBloc.showSnackBar(context, "Deleted Successfully");
          }
        },
        builder: (BuildContext buildContext, TodoStates state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          return whatTodoList.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            "${index + 1}. ${whatTodoList[index].todoName}",
                          ),
                          Checkbox(
                              value: whatTodoList[index].todoStatus ,
                              onChanged: null)
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          todoBloc.add(DeleteTodoEvent(todoIndex: index));
                        },
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                                value: todoBloc,
                                child: CreateUpdateDialog(
                                  isUpdate: true,
                                  todoData: whatTodoList[index],
                                  index: index,
                                )));
                      },
                    );
                  },
                  itemCount: whatTodoList.length,
                )
              : const Center(
                  child: Text("Nothing to do"),
                );
        },
      )),
    );
  }
}
