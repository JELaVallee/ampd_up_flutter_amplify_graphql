# Welcome to Amp'd Up Flutter Development with AWS Amplify!

![image](https://user-images.githubusercontent.com/4291961/114327253-47b3b200-9b06-11eb-837e-f62b032ff927.png)

**Please excuse the WIP while we get things put together... - @JELaVallee**
## Overview
This repository is designed to be both a quick reference for a bare-bones implementation of Flutter and AWS Amplify _as well as_ a functional tutorial for turning a static stateful Flutter app into one backed with AWS Amplify provisioned services.

### 1. Access the completed project 
If you just want to get the whole working demo project up and running:

1. Be sure to [Setup Your Environment]()! **TODO: Link to Section**
1. Clone this repository at branch `trunk` 
1. Follow the instructions in [Run the Amplified ToDo App]() **TODO: Link to Section**

### 2. Access the guided tutorial
If you would prefer to walk through the tutorial exercise step-by-step to learn how all the pieces fit together:

1. Be sure to [Setup Your Environment]()!
2. Clone this repository at branch `01-todo-scaffolding` 
3. Open the README.md in that branch at [1. Setting The Stage: The Bare-bones ToDo App]() **TODO: Link to Section**

## Getting Started!
Before we get jamming, let's make sure you're all tuned up! To get the most out of this session, you'll need to have a few things working in your environment:

1. The Flutter developer environment setup to your flavor of IDE (I love VSCode, myself): [Getting Started with Flutter](https://flutter.dev/docs/get-started/install) 
2. An Amazon AWS account that you have root-access to: [Amazon AWS: Sign-up](https://portal.aws.amazon.com/billing/signup#/start)
3. The AWS Amplify CLI tooling installed on your system: [AWS Amplify CLI: Installation](https://docs.amplify.aws/cli/start/install)



<!-- This section to be in 01-todo-scaffolding -->
## 1. Setting The Stage: The Bare-bones ToDo App
1. Overview of the Boring ToDo Flutter App
1. Demo the Boring ToDo Flutter App 

<!-- This section to be in 02-amplify-init -->
## 2. Configure: Initialize Amplify
1. Run command `amplify init`...
1. Explain what happened...
    1. Show the `amplifyconfig.yml` file
    1. Show the command `amplify status` output 
1. Add the `Amplify.init()` to main.dart initialization
    1. **TODO: Explain why...** 

<!-- This section to be in 03-amplify-add-api -->
## 3. "Amplifying "our ToDo App
### 3.1 Scaffold: Create The GraphQL API Endpoint
1. Run command `amplify add api` and set it up for a GraphQL-Todo schema
1. Explain what happened...
    1. Show the generated ToDo Schema artifacts
    1. **TODO: More details...** 
1. Run command `amplify push api`
1. Explain what's going on...
    1. Explain the CloudFormation output 
1. Run command `amplify api console`
1. Walk through the wiring on the AWS side of things...
    1. Start at the Amplify API Console
    1. Drill down to the AppSync-GraphQL Console
    1. Show and explain the GraphQL Resolvers
    1. Go back to the Amplify API Console
    1. Drill down to the DynamoDB Console
    1. Show and explain the Dynamo ToDo record set 


### 3.2 Demo: Talk to GraphQL interface with Altair GraphQL Client
1. Explain the Altair GraphQL Client interface
    1. Retrieve the GQL Catalog
    1. Explain the various Schema interfaces that were returned 
1. List ToDo items [GraphQL Snippet](#graphql-query-to-list-the-todos) 
1. Insert a ToDo item [GraphQL Snippet](#graphql-query-to-create-a-new-todo)
1. Change the completed state of a ToDo item [GraphQL Snippet](#graphql-query-to-mutate-a-todo)
1. Delete a ToDo item [GraphQL Snippet](#graphql-query-to-delete-a-todo)

### 3.3 Code: Integrate the Endpoint... Amp'd Up ToDo's!
Let's get back to that "boring ToDo App"...
1. Open the `pubspec.yaml` file for the project...
	1. Add the `amplify_flutter` packages we're going to need to import
	1. Run the command `flutter pub get` to add the packages to your environment
1. Open the `lib/main.dart` file...
	1. Add the amplify packages and configuration imports
	2. **TODO: Snippet of the import Code**
	3. Add the `Amplify.API` plugin to the Init logic
	4. **TODO: Snippet of the Init Code** 

<!-- This section to be in 04-wire-list-todos-api -->

## 4. Jammin' with our Amplified GraphQL Service
### 4.1 Wire up the list retrieval GraphQL query
  1. **TODO Snippet of the getTodoList Code** 
  2. Run the app: `flutter run -d {device-name}`
  3. Add a new ToDo item via Altair GraphQL Client and then refresh in the ToDo App
<!-- This section to be in 05-wire-add-todo-api -->
### 4.2 Wire up the change state GraphQL query
  1. **TODO: Snippet of the updateTodoList Code** 
  2. Demo changing the completed state of a ToDo item
### 4.3 Wire up adding a ToDo item
  1. **TODO: Snippet of the insertTodo Code**
  2. Demo adding a ToDo item 
### 4.4 Wire up deleting a ToDo item
  1. **TODO: Snippet of the deleteTodo Code**
  2. Demo deleting a ToDo item 

## 6. Review Process

# Addenda
## A. References
1. **AWS Amplify & Managed Services Refs**
	- AWS Amplify for Flutter Getting Started Guide: [AWS Docs - All Framworks](https://docs.amplify.aws/) | [AWS Docs - Flutter SDK]( https://docs.amplify.aws/start/q/integration/flutter)
	- AWS Amplify Flutter SDK: https://github.com/aws-amplify/amplify-flutter
	- AWS Amplify GraphQL API Library: [AWS Docs](https://docs.amplify.aws/lib/graphqlapi/getting-started/q/platform/flutter) | [GitHub](https://github.com/aws-amplify/amplify-flutter/tree/master/packages/amplify_api)
	- AWS Amplify CLI: [AWS Docs](https://docs.amplify.aws/cli) | [GitHub](https://github.com/aws-amplify/amplify-cli) 
	- AWS AppSync: [AWS Docs - Developer Guide](https://docs.aws.amazon.com/appsync/latest/devguide/what-is-appsync.html) | [AWS Docs - API Ref](https://docs.aws.amazon.com/appsync/latest/APIReference/Welcome.html)
	- AWS DynamoDB: [AWS Docs - Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html) | [AWS Docs - API Ref ](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/Welcome.html)
2. **GraphQL Resources & Tools**
	- GraphQL Reference & Community Home: https://graphql.org/
	- GraphQL SQL Resolver Tutorial: [Serverless.com:Blog](https://www.serverless.com/blog/graphql-api-mysql-postgres-aurora)
	- Altair GraphQL Client Chrome Extension: [Chrome Store](https://chrome.google.com/webstore/detail/altair-graphql-client/)
	- `graphql-flutter` 100% Dart Based GraphQL Client: [GitHub](https://github.com/zino-app/graphql-flutter) | [pub.dev](https://pub.dev/packages/graphql_flutter)

## B. Code Snippets

### B.1 GraphQL Queries 
#### GraphQL query to list the ToDo's:
```graphql
query{
  listTodos{
    items {
      id
      name
      completed
    }
  }
}
```

#### GraphQL query to create a new ToDo:
```graphql
mutation{
  createTodo(input: {id:"2", name: "Second Todo Item", completed: false}){
    id
    name
    description
    completed
    createdAt
    updatedAt
  }
}
```
#### GraphQL query to mutate a ToDo:
```graphql
# Changes the 'completed' status to true
mutation{
  updateTodo(input: {id: "2", completed: true}){
          id
          name
          completed
        }
}
```

#### GraphQL query to delete a ToDo:
```graphql
mutation{
  deleteTodo(input: {id: "2"}){
    id
    name
    completed
  }
}
```

### B.2 Amplify Flutter GraphQL Service Calls 
#### Amplify SDK imports for Flutter App:
**In file [/lib/main.dart : L5-L10](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/caa887c43eadae8e1e83ee07696410d124bb21ff/lib/main.dart#L5-L10) :**

```dart
...

// Amplify packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';


// Amplify configuration
import 'amplifyconfiguration.dart';

...
```

#### Service call to query a list the ToDo's:
**In file [/lib/main.dart : L77-L108](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/018ada52e534c0598d3a48fbb643dc31bfc0d4fc/lib/main.dart#L77-L108) :**

```dart
...

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
  
...
```

#### Service call to create a new ToDo:
**In file [/lib/main.dart : L110-L136](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/018ada52e534c0598d3a48fbb643dc31bfc0d4fc/lib/main.dart#L110-L136) :**

```dart
...

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

...
```

#### Service call to mutate a ToDo:
**In file [/lib/main.dart : L138-L164](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/018ada52e534c0598d3a48fbb643dc31bfc0d4fc/lib/main.dart#L138-L164) :**

```dart
...

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
  
...
```

#### Service call to delete a ToDo:
**In file [/lib/main.dart : L166-L188](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/018ada52e534c0598d3a48fbb643dc31bfc0d4fc/lib/main.dart#L166-L188) :**

```dart
...

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
  
...
``` 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzNTI4NDY0MDMsLTEwNTYzNTM0NTQsOT
E0OTg0MjI1LC0xMTM0MzEyNzU5LC0xNDY5MjcxNTgzLDQwNDMz
OTg3OCwtMTA5MzA3Mzk1Myw1NTQyMzkxMSwyMDg4MzIwODgsLT
QxMDc3MDgwMyw3Mjc4MjU1OTAsMTIwMjM2MjI5MCwtNTE5MjY0
MDYsLTc5ODg2NDY1NCwtMTg1NzA3Njg2OV19
-->