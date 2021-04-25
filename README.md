# Welcome to Amp'd Up Flutter Development with AWS Amplify!

![image](https://user-images.githubusercontent.com/4291961/114327253-47b3b200-9b06-11eb-837e-f62b032ff927.png)


## 4. Jammin' with our Amplified GraphQL Service
### 4.1 Wire up the list retrieval GraphQL query
First priority will be getting back a collection of our ToDo Items for displaying in our Amp'd Up ToDo List App.

Taking a look in `main.dart` we can see the newly added API `listItems` query code:

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

Have a look at our `gqlQuery` String... Look's familiar!

The `operation` is where we send our query to the Amplify SDK to execute against our API while the remainder of the method is an admittedly "clunky" unmarshalling of query's `response.data`... 

#### Design Note:
For the sake of this tutorial, we are going to keep this "clunky" pattern. The author would like to note that this is **not recommended** practice for durable/supportable production code. One feature missing in the current AWS Amplify for Flutter tooling is the ability to codegen client interfaces for the GraphQL endpoint, a feature offered on other Amplify SDK platforms. 

At this time, there are several options for GraphQL Model-Entity mapping available in dart, which use the fully-generated GraphQL Schema in your application to generate dart model and query artifacts. This significantly reduces the chance of mapping/hydration issues and treats the GraphQL Schema as the contract-of-truth for both the API's client and service implementations. Check out the [Artemis:Pub.Dev](https://pub.dev/packages/artemis) project to learn more!
 
#### Try it out!
Let's run our new Amp'd Up ToDo List app: `flutter run -d {device-name}`

When the app launches, we should see our ToDo Items in DynamoDB listed like this:

![image](https://user-images.githubusercontent.com/4291961/116003619-b4ca4b80-a5cc-11eb-8bc6-61b5cdf4f64a.png)

We're now wired to our GraphQL API! Try changing something in DynamoDB or AWS AppSync Console and then hit the "Refresh" button... Let's keep going!

### 4.2 Wire up creating a ToDo item
Checkout the branch `05-wire-add-todo-api` ...

We now have similar logic as above, but in a "mutation" request, the key difference being mapping values from our new `ToDo` object into the mutation query.

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

If we run our app, we can now use the floating "+" action button to create a new ToDo in our API.

![image](https://user-images.githubusercontent.com/4291961/116005096-800dc280-a5d3-11eb-8f8c-62d15d972dff.png)

![image](https://user-images.githubusercontent.com/4291961/116005074-6a989880-a5d3-11eb-8f10-cb1104a1bce5.png)

Now we're on a roll! Let's make those checkboxes work!

### 4.3 Wire up changing a ToDo item
Checkout the branch `06-wire-change-todo-api` ...

Much like with our createToDo mutation, this new mutation recieves passed parameters...

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

If we run our app, we can now interact with checkboxes on the Amp'd Up ToDO List view and see the changes on the backend in DynamoDB. Now we're Rockin'!

One last thing to round out our CRUD set, we need to give that garbage can icon something "to do"...

### 4.4 Wire up deleting a ToDo item
Checkout the branch `07-wire-delete-todo-api`...

Same as it ever was... Our deleteTodo mutation is a reworking of our original GraphQL deletion mutation with similar parameter passing to identify the ToDo Item we want to delete. (Like real Rock Stars, we're doing this without any confirmation dialog... ;-) 

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

Run you flutter app again, and try it out... All CRUD operations should be working now. We'll leave it as an exercise for you to add an "update name" feature... Give it try!

### 4.5 The End... for now...
We've successfully used the Amplify CLI tooling and the Amplify Flutter SDK to "Amp Up" our boring ToDo List App! If you'd like to learn more about Amplify, check out the [References Section](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/trunk/README.md#a-references) and keep an eye on this repository for future updates!
