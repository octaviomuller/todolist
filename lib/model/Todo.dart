import 'package:flutter/material.dart';

class Todo {
  final String name;
  final int priority;
  bool done;

  Todo(this.name, this.priority, this.done);

  getPriorityColor() {
    switch(priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3: 
        return Colors.yellow;
    }
  }
}