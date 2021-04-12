# Welcome to Amp'd Up Flutter Development with AWS Amplify!

![image](https://user-images.githubusercontent.com/4291961/114327253-47b3b200-9b06-11eb-837e-f62b032ff927.png)

**Please excuse the WIP while we get things put together... - @JELaVallee**


## 1. Pre-Requisites: Setting The Stage
1. Overview of Amplify-CLI Installation
1. Overview of the Boring ToDo Flutter App
1. Demo the Boring ToDo Flutter App 

## 2. Configure: Initialize Amplify
1. Run command `amplify init`...
1. Explain what happened...
    1. Show the `amplifyconfig.yml` file
    1. Show the command `amplify status` output 
1. Add the `Amplify.init()` to main.dart initialization
    1. **TODO: Explain why...** 

## 3. Scaffold: Create The GraphQL API Endpoint
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

## 4. Demo: Talk to GraphQL interface with Altair GraphQL Client
1. Explain the Altair GraphQL Client interface
    1. Retrieve the GQL Catalog
    1. Explain the various Schema interfaces that were returned 
1. List ToDo items [GraphQL Snippet](#graphql-query-to-list-the-todos) 
1. Insert a ToDo item [GraphQL Snippet](#graphql-query-to-create-a-new-todo)
1. Change the completed state of a ToDo item [GraphQL Snippet](#graphql-query-to-mutate-a-todo)
1. Delete a ToDo item [GraphQL Snippet](#graphql-query-to-delete-a-todo)

## 5. Code: Integrate the Endpoint... Amp'd Up ToDo's!
Let's get back to that "boring ToDo App"...
### 5.1 Connect the Amplify SDK to our ToDo App
1. Open the `pubspec.yaml` file for the project...
	1. Add the `amplify_flutter` packages we're going to need to import
	1. Run the command `flutter pub get` to add the packages to your environment
1. Open the `lib/main.dart` file...
	1. Add the amplify packages and configuration imports
	2. **TODO: Snippet of the import Code**
	3. Add the `Amplify.API` plugin to the Init logic
	4. **TODO: Snippet of the Init Code** 

### 5.1 Jammin' with our Amplified GraphQL Service
1. Wire up the list retrieval GraphQL query
	1. **TODO Snippet of the getTodoList Code** 
	2. Run the app: `flutter run -d {device-name}`
	3. Add a new ToDo item via Altair GraphQL Client and then refresh in the ToDo App
2. Wire up the change state GraphQL query
    1. **TODO: Snippet of the updateTodoList Code** 
3. Demo changing the completed state of a ToDo item
4. Wire up adding a ToDo item
    1. **TODO: Snippet of the insertTodo Code**
5. Demo adding a ToDo item 
6. Wire up deleting a ToDo item
    1. **TODO: Snippet of the deleteTodo Code**

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
#### Service call to query a list the ToDo's:
https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/caa887c43eadae8e1e83ee07696410d124bb21ff/lib/main.dart#L5-L10

#### Service call to create a new ToDo:


#### Service call to mutate a ToDo:

#### Service call to delete a ToDo:

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTIwMjM2MjI5MCwtNTE5MjY0MDYsLTc5OD
g2NDY1NCwtMTg1NzA3Njg2OV19
-->