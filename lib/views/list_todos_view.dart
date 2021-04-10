import 'package:flutter/material.dart';
import '../models/todo.dart';

class ListTodosView extends StatelessWidget {
  final List<Todo> todoItems;
  final reloadTodoList;
  final onTodoToggle;
  final onDeleteTodo;

  ListTodosView(
      {@required todoItems,
      @required onTodoToggle,
      @required reloadTodoList,
      @required onDeleteTodo}) :
        this.todoItems = todoItems ?? [],
        this.onTodoToggle = onTodoToggle ?? null,
        this.reloadTodoList = reloadTodoList ?? null,
        this.onDeleteTodo = onDeleteTodo ?? null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reload List',
            onPressed: () {
              this.reloadTodoList();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: todoItems.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(todoItems[index].name),
              value: todoItems[index].isCompleted,
              controlAffinity: ListTileControlAffinity.leading,
              secondary: IconButton(
                icon: Icon(Icons.delete_forever_rounded),
                tooltip: "Delete Todo Item",
                onPressed: () => onDeleteTodo(todoItems[index]),
              ),
              onChanged: (_) => onTodoToggle(todoItems[index]),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addtodo'),
          child: Icon(Icons.add)),
    );
  }
}