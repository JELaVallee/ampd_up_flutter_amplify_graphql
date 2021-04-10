import 'package:flutter/material.dart';

class AddTodoView extends StatefulWidget {
  final onTodoAdd;

  AddTodoView({@required this.onTodoAdd});

  @override
  State<StatefulWidget> createState() {
    return AddTodoState();
  }
}

class AddTodoState extends State<AddTodoView> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Todo Item')),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                  autofocus: true,
                  controller: textController,
                  decoration: InputDecoration(
                      labelText: 'Enter your new todo item...')))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          widget.onTodoAdd(textController.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}