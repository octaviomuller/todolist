import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/Todo.dart';
import 'package:todo/services/CloudFirestore.dart';
import 'package:todo/widget/TodoList.dart';

class Home extends StatefulWidget {
  final String title;

  Home(this.title);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todoList = [];
  TextEditingController _todoName = TextEditingController();
  int _todoPriority = 1;

  void addTodo(Todo todo) {
    setState(() {
      todoList.add(todo);
    });
  }

  void initiateDialog() {
    setState(() {
      _todoName.clear();
      _todoPriority = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream todos = CloudFirestoreService().listenDocuments('todos');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: todos,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return TodoList(snapshot.data.docs.map((DocumentSnapshot document) =>
              Todo(document.data()['name'], document.data()['priority'],
                  document.data()['done'])));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          initiateDialog(),
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (contex, setState) {
                  return AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel")),
                      TextButton(
                        onPressed: () => {
                          addTodo(Todo(_todoName.text, _todoPriority, false)),
                          Navigator.pop(context),
                        },
                        child: Text("Continue"),
                      ),
                    ],
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: _todoName,
                              decoration:
                                  InputDecoration(labelText: "To Do Name")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => setState(() => _todoPriority = 1),
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  color: _todoPriority == 1
                                      ? Colors.grey[300]
                                      : Colors.transparent,
                                  child: Icon(Icons.flag_rounded,
                                      color: Colors.red),
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => setState(() => _todoPriority = 2),
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  color: _todoPriority == 2
                                      ? Colors.grey[300]
                                      : Colors.transparent,
                                  child: Icon(Icons.flag_rounded,
                                      color: Colors.orange),
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => setState(() => _todoPriority = 3),
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  color: _todoPriority == 3
                                      ? Colors.grey[300]
                                      : Colors.transparent,
                                  child: Icon(Icons.flag_rounded,
                                      color: Colors.yellow),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
