# Welcome to Amp'd Up Flutter Development with AWS Amplify!

![image](https://user-images.githubusercontent.com/4291961/114327253-47b3b200-9b06-11eb-837e-f62b032ff927.png)

## Overview
This repository is designed to be both a quick reference for a bare-bones implementation of Flutter and AWS Amplify _as well as_ a functional tutorial for turning a static stateful Flutter app into one backed with AWS Amplify provisioned services.

This tutorial was presented at the [DC Dev Community](https://devcommunity.org) Flutter Meetup on [April 26, 2021](https://www.meetup.com/DCFlutter/events/277453095/). Come back soon for the YouTube link for the full presentation!

## Getting Started!
Before we get jamming, let's make sure you're all tuned up! To get the most out of this session, you'll need to have a few things working in your environment:

1. The Flutter developer environment setup to your flavor of IDE (I love VSCode, myself): [Getting Started with Flutter](https://flutter.dev/docs/get-started/install) 
2. An Amazon AWS account that you have root-access to: [Amazon AWS: Sign-up](https://portal.aws.amazon.com/billing/signup#/start)
3. The AWS Amplify CLI tooling installed on your system: [AWS Amplify CLI: Installation](https://docs.amplify.aws/cli/start/install)

(Note: When following the Amplify CLI setup instructions, be sure to copy the AccessKeyID/SecretKey for the user account you created for running Amplify as documented [here](https://docs.amplify.aws/lib/project-setup/prereq/q/platform/flutter#sign-up-for-an-aws-account) )

### Start the guided tutorial
This tutorial works by checking out subsequent branches from this repository. To get started, clone this repo and then follow these instructions:

1. Be sure to [Setup Your Environment](#getting-started)!
2. Check-out the branch `01-todo-scaffolding` 
3. Open the README.md in that branch... Click here: [1. Setting The Stage: The Bare-bones ToDo App](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/01-todo-scaffolding/README.md#1-setting-the-stage-the-bare-bones-todo-app)

If you're more of a visual-learner or would like to see this tutorial in-action, check out the [video of the Demo Walk-Through](https://drive.google.com/file/d/10M31SingxWaT11Y_w6T7SjzL6p6fFcrA/view?usp=sharing)

## Coming Soon...
If you've enjoyed this demo, then stay tuned! We'll be adding other Amp'd Up service examples, including:

1. Providing Authentication and User Services with the AWS Cognito service.
2. Enhancing the ToDo App data schema interactively with AWS AppSync's GraphQL API service.
3. Adding cloud storage with AWS S3 service.
4. Stay tuned and happy (Amp'd Up) Flutter development!

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
eyJoaXN0b3J5IjpbLTE5NDU0NjMxOTAsNTgyNTg2MTczLC0yMD
cxNTcyODgxLC0xMDU2MzUzNDU0LDkxNDk4NDIyNSwtMTEzNDMx
Mjc1OSwtMTQ2OTI3MTU4Myw0MDQzMzk4NzgsLTEwOTMwNzM5NT
MsNTU0MjM5MTEsMjA4ODMyMDg4LC00MTA3NzA4MDMsNzI3ODI1
NTkwLDEyMDIzNjIyOTAsLTUxOTI2NDA2LC03OTg4NjQ2NTQsLT
E4NTcwNzY4NjldfQ==
-->
