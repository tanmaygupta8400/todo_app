import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todo_bloc.dart';
import '../../bloc/todo_events.dart';
import '../../model/todo_model.dart';

class CreateUpdateDialog extends StatefulWidget {
  final TodoData? todoData;
  final bool isUpdate;
  final int index;

  const CreateUpdateDialog(
      {super.key, required this.isUpdate, this.todoData, required this.index});


  @override
  State<CreateUpdateDialog> createState() => _CreateUpdateDialogState();
}

class _CreateUpdateDialogState extends State<CreateUpdateDialog> {
  @override

  bool todoStatus = false;
  TextEditingController textEditingController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      textEditingController.text = widget.todoData!.todoName;
      todoStatus = widget.todoData!.todoStatus;
    }
  }

  Widget build(BuildContext context) {
    TodoBloc whatTodoBloc = BlocProvider.of<TodoBloc>(context);






    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "What todo..."),
          controller: textEditingController,
        ),
        SizedBox(height: 8),
        Checkbox(
          value: todoStatus,
    onChanged:(bool? newValue){
    setState(() {
      todoStatus = newValue!;

    });}
        ),
         SizedBox(height: 8),
        ElevatedButton(
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                if (widget.isUpdate) {
                  whatTodoBloc.add(UpdateTodoEvent(
                      todoData: TodoData(
                        todoId: widget.todoData!.todoId,
                        todoName: textEditingController.text,
                        todoStatus: todoStatus
                      ),
                      index: widget.index));
                } else {
                  whatTodoBloc.add(CreateTodoEvent(
                      todoData: TodoData(
                    todoId: widget.index,
                    todoName: textEditingController.text,
                        todoStatus: todoStatus
                  )));
                }
              }
            },
            child: Text(widget.isUpdate ? "Update" : "Create"))
      ],
    ));
  }
}
