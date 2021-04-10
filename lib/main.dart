import 'dart:convert';

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
  List<Todo> todoItems = [];

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
      _updateTodoList();
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
    try {
      String gqlQuery = '''query{
        listTodos{
          items {
            id
            name
            completed
          }
        }
      }''';

      var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: gqlQuery));

      var response = await operation.response;
      var data = response.data;
      Map<String, dynamic> listTodos = jsonDecode(data);
      List<dynamic> todoResponseItems =
          listTodos['listTodos']['items'];
      List<Todo> todoItemsList = [];
      todoResponseItems.forEach((item) {
        print('Loaded Item: ' + item.toString());
        todoItemsList.add(Todo(item['id'], item['name'], item['completed']));
      });
      setState(() {
        todoItems = todoItemsList;
      });
    } catch (e) {
      print(e);
    }
  }

  void _addTodoItem(Todo todo) async {
    try {
      String gqlMutation =
          '''mutation CreateTodo(\$name: String!, \$completed: Boolean!){
            createTodo(input: {name: \$name, completed: \$completed}){
              id
              name
              completed
            }
          }''';

      var gqlRequest =
          GraphQLRequest<String>(document: gqlMutation, variables: {
        "name": todo.name,
        "completed": todo.isCompleted,
      });

      var operation = Amplify.API.mutate(request: gqlRequest);
      var response = await operation.response;
      var data = response.data;

      print('Mutation result: ' + data);
      _updateTodoList();
    } catch (e) {
      print(e);
    }
  }

  void _updateTodoItem(Todo todo) async {
   try {
      String gqlMutation =
          '''mutation UpdateTodo(\$id: ID!, \$completed: Boolean){
        updateTodo(input: {id: \$id, completed: \$completed}){
          id
          name
          completed
        }
      }''';

      var gqlRequest =
          GraphQLRequest<String>(document: gqlMutation, variables: {
        "id": todo.id,
        "completed": !todo.isCompleted,
      });

      var operation = Amplify.API.mutate(request: gqlRequest);
      var response = await operation.response;
      var data = response.data;

      print('Mutation result: ' + data);
      _updateTodoList();
    } catch (e) {
      print(e);
    }
  }

  void _deleteTodoItem(Todo todo) async {
    try {
      String gqlMutation = '''mutation DeleteTodo(\$id: ID!){
        deleteTodo(input: {id: \$id}){
          id
        }
      }''';

      var gqlRequest =
          GraphQLRequest<String>(document: gqlMutation, variables: {
        "id": todo.id,
      });

      var operation = Amplify.API.mutate(request: gqlRequest);
      var response = await operation.response;
      var data = response.data;

      print('Mutation result: ' + data);
      _updateTodoList();
    } catch (e) {
      print(e);
    }
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
