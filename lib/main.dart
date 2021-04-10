import 'package:flutter/material.dart';

// Amplify packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

// Amplify configuration
import 'amplifyconfiguration.dart';

// Models
import './models/todo.dart';

// Views
import './views/list_todos_view.dart';
import './views/add_todo_view.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TodoWidget();
  }
}

class TodoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoWidget> {
  List<Todo> todoItems = [
    new Todo('1', 'This is ToDo Item 1... exciting!', false),
    new Todo('2', 'This is ToDo Item 2... exilirating!', false),
    new Todo('3', 'This is ToDo Item 3... amazing!', false),
    new Todo('4', 'This is ToDo Item 4... fantastic!', false),
    new Todo('5', 'This is ToDo Item 5... spectacular!', false),
  ];

  @override
  void initState() {
    super.initState();
    _initAmplify();
  }

  // Amplify session initializer
  void _initAmplify() async {
    // Add API Plugin
    Amplify.addPlugin(AmplifyAPI());

    // Configure Amplify SDK
    try {
      await Amplify.configure(amplifyconfig);
      print("Amplify successfully configured!!!");
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify; Something failed...");
    }
  }

  // Callbacks
  // Switch completion state for toggled todo item
  void onTodoToggle(Todo todo) {
    _updateTodoItem(todo);
  }

  // Create new todo item
  void onTodoAdd(String name) {
    _addTodoItem(Todo("1111", name, false));
  }

  void onDeleteTodoItem(Todo todo) {
    _deleteTodoItem(todo);
  }

  // Service Handlers
  void _updateTodoList() async {
    return;
  }

  void _addTodoItem(Todo todo) async {
    setState(() {
      todoItems.add(todo);
    });
    _updateTodoList();
  }

  void _updateTodoItem(Todo todo) async {
    setState(() {
      todo.completed = !todo.isCompleted;
    });
    _updateTodoList();
  }

  void _deleteTodoItem(Todo todo) async {
    setState(() {
      todoItems.remove(todo);
    });
    _updateTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => ListTodosView(
              todoItems: todoItems,
              onTodoToggle: onTodoToggle,
              reloadTodoList: _updateTodoList,
              onDeleteTodo: onDeleteTodoItem),
          '/addtodo': (context) => AddTodoView(onTodoAdd: onTodoAdd)
        });
  }
}
