import 'package:flutter/material.dart';
import 'package:todo/model/Todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  TodoItem(this.todo);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: widget.todo.done,
            onChanged: (value) => setState(() {
              widget.todo.done = value;
            }),
          ),
          Text(widget.todo.name),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Icon(Icons.flag_rounded, color: widget.todo.getPriorityColor()),
          ),
        ],
      ),
    );
  }
}
