import 'package:flutter/material.dart';
import 'package:todo/model/Todo.dart';
import 'package:todo/widget/TodoItem.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todoList;

  TodoList(this.todoList);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemBuilder: (context, index) => TodoItem(widget.todoList[index]),
          itemCount: widget.todoList.length),
    );
  }
}
