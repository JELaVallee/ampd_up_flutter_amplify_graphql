# Welcome to Amp'd Up Flutter Development with AWS Amplify!

![image](https://user-images.githubusercontent.com/4291961/114327253-47b3b200-9b06-11eb-837e-f62b032ff927.png)


<!-- This section to be in 03-amplify-add-api -->
## 3. "Amplifying" our ToDo App
### 3.1 Scaffold: Create The GraphQL API Endpoint
In this step we will build our GraphQL API backend to provide ToDo data model interfaces for our application.

To tell Amplify that we want a new API service, run the command `amplify add api` and provide the following options:

```
$ amplify add api
? Please select from one of the below mentioned services: GraphQL
? Provide API name: ampduptest01
? Choose the default authorization type for the API API key
? Enter a description for the API key: ampduptest01key
? After how many days from now the API key should expire (1-365): 7
? Do you want to configure advanced settings for the GraphQL API Yes, I want to make some additional changes.
? Configure additional auth types? No
? Enable conflict detection? No
? Do you have an annotated GraphQL schema? No
? Choose a schema template: Single object with fields (e.g., “Todo” with ID, name, description)

The following types do not have '@auth' enabled. Consider using @auth with @model
         - Todo
Learn more about @auth here: https://docs.amplify.aws/cli/graphql-transformer/auth


GraphQL schema compiled successfully.

Edit your schema at /home/jelavallee/workspace/demos/ampd_up_test01/amplify/backend/api/ampduptest01/schema.graphql or place .graphql files in a directory at /home/jelavallee/workspace/demos/ampd_up_test01/amplify/backend/api/ampduptest01/schema
? Do you want to edit the schema now? No
Successfully added resource ampduptest01 locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud
```

### 3.2. What just happened?
Amplify just generated all of the artifacts and configuration needed to deploy a new GraphQL API (via AWS AppSync) to the cloud! Before we "push" that new configuration, let's take a look at one important file, the GraphQL Schema for our new ToDo Entity model:

In file `/amplify/backend/api/ampduptest01/schema.graphql`:

```dart
type Todo @model {
  id: ID!
  name: String!
  description: String
}
```

This is a generic template schema created by Amplify's API setup wizard. If we compare it to the dart model for our ToDo App, we can see we're missing something:

In file `lib/models/todo.dart`:

```dart
class Todo {
  String _id = '';
  String _name = '';
  String _description = '';
  bool _completed = false;

  // Default constructor
  Todo(this._id, this._name, this._completed);

  // Obligatory getter/setters
  String get id => this._id;
  set id(String id) => this._id = id;

  String get name => this._name;
  set name(String name) => this._name = name;

  String get description => this._description;
  set description(String description) => this._description = description;

  bool get isCompleted => this._completed;
  set completed(bool state) => this._completed = state;
}
```

Our ToDo GraphQL Schema doesn't have a `completed` property! No worries... We can add it ourselves:

In file `/amplify/backend/api/ampduptest01/schema.graphql`:

```dart
type Todo @model {
  id: ID!
  name: String!
  description: String
  completed: Boolean!
}
```

With the `completed` field added to the schema (with the `!` modifier to indicate this is a required field), we can now push our new Amplify API to the AWS Cloud... Let's do it!

### 3.3. Deploy the New API!
To deploy our new GraphQL API with Amplify, simply run the command `amplify push` and you should see the following output:

```
$ amplify push
✔ Successfully pulled backend environment dev from the cloud.

Current Environment: dev

| Category | Resource name | Operation | Provider plugin   |
| -------- | ------------- | --------- | ----------------- |
| Api      | ampduptest01  | Create    | awscloudformation |
? Are you sure you want to continue? Yes

The following types do not have '@auth' enabled. Consider using @auth with @model
         - Todo
Learn more about @auth here: https://docs.amplify.aws/cli/graphql-transformer/auth


GraphQL schema compiled successfully.

Edit your schema at /home/jelavallee/workspace/demos/ampd_up_test01/amplify/backend/api/ampduptest01/schema.graphql or place .graphql files in a directory at /home/jelavallee/workspace/demos/ampd_up_test01/amplify/backend/api/ampduptest01/schema
⠼ Updating resources in the cloud. This may take a few minutes...

...
```

This will be followed by the log output from AWS CloudFormation which Amplify is orchestrating to deploy our new API components. After a couple of minutes (YMMV), Amplify will print out the following:

```
...

✔ All resources are updated in the cloud

GraphQL endpoint: https://{appsync-endpoint-arn}.appsync-api.us-east-1.amazonaws.com/graphql
GraphQL API KEY: {api-endpoint-access-key}
```

Be sure to copy that information down for our next step... You can always find it by running the command `amplify status`:

```
$ amplify status

Current Environment: dev

| Category | Resource name | Operation | Provider plugin   |
| -------- | ------------- | --------- | ----------------- |
| Api      | ampduptest01  | No Change | awscloudformation |

GraphQL endpoint: https://{appsync-endpoint-arn}.appsync-api.us-east-1.amazonaws.com/graphql
GraphQL API KEY: {api-endpoint-access-key}
```

Before we continue to integrating this endpoint with our ToDo App, let's have a look at what Amplify just accomplished...

### 3.4. Exploring our New API 

Let's start with a look at the new AppSync GraphQL API topology that Amplify deployed.

To access our AWS Amplify Console, run the command `amplify api console`

This will open a new browser window to your AWS AppSync Console (you may be prompted to login to your AWS account):

![image](https://user-images.githubusercontent.com/4291961/116000241-66618080-a5bd-11eb-8531-ba45721a6e54.png)

Let's first take a look at our _fully generated_ GraphQL Schema by selecting the "Schema" tab:

![image](https://user-images.githubusercontent.com/4291961/116000332-be988280-a5bd-11eb-9494-a023a74f7ffb.png)

Notice that in addition to the entity definition we created in the previous section, we also have all of the sub-entities, query/mutation entities, and methods defined. Amplify did all of that work for us!

Let's dig deeper... If we select the "Data Sources" tab, we can see:

![image](https://user-images.githubusercontent.com/4291961/116000408-10410d00-a5be-11eb-84ca-09ad71c3a178.png)

In addition creating our GraphQL API, Amplify also created a DynamoDB data source based on our GraphQL Schema to store our data. Let's have a look at that...

Click the "Resource" link to our new DynamoDB data source and we see the DynamoDB Console for our new data source:

![image](https://user-images.githubusercontent.com/4291961/116000498-82b1ed00-a5be-11eb-8bed-3094e073612e.png)

Looks like all of our topology is in place and ready to use! Let's take our new GraphQL API for a spin and add some ToDo data... 

### 3.5. Interacting GraphQL API with the AppSync GraphQL Client
To learn the in's and out's of our new GraphQL API, we'll use the GraphQL Client _built into_ the AWS AppSync Console. Going back to the AppSync Console for our API, select the "Query" tab, like so:

![image](https://user-images.githubusercontent.com/4291961/116000749-75e1c900-a5bf-11eb-82e7-45729ce01319.png)


#### 3.5.1. Creating a ToDo Item
Let's start by creating a few new ToDo items...

Copy the following "Create mutation" query to the query panel:

```grpahql
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

Like so:

![image](https://user-images.githubusercontent.com/4291961/116000904-0ddfb280-a5c0-11eb-8b38-292d5150b9cf.png)

Than click the "Play" button at the top of the Query panel to execute the `createTodo` mutation. We should see the following response from the GraphQL API:

![image](https://user-images.githubusercontent.com/4291961/116000949-41224180-a5c0-11eb-87fb-c5cd75c1112c.png)

Now, let's check our DynamoDB Console... On the DynamoDB details view for our new data source, open the "Items" tab and click the "Start Search" button... We should see the new record in the database, like so:

![image](https://user-images.githubusercontent.com/4291961/116001060-b0983100-a5c0-11eb-832e-a5f5047e0e2b.png)

Success! We have a functional GraphQL endpoint.

#### 3.5.2. Experimenting with GraphQL
Create a few more ToDo Items as we did in the previous section... When done, our DynamoDB should look like this:

![image](https://user-images.githubusercontent.com/4291961/116001154-256b6b00-a5c1-11eb-85fe-54d339053167.png)

Let's start with listing our ToDo items... If we use the following query in the AppSync GraphQL Console for our new API:

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

And we should see all of our new ToDo Items returned in a GraphQL response:

![image](https://user-images.githubusercontent.com/4291961/116001244-85621180-a5c1-11eb-9be0-9d37f5eaebf3.png)

Awesome! Let's try Deleting one of those new ToDo Items... Run the following query:

```graphql
mutation{
  deleteTodo(input: {id: "2"}){
    id
    name
    completed
  }
}
```

Now, let's check our DynamoDB:

![image](https://user-images.githubusercontent.com/4291961/116001341-06b9a400-a5c2-11eb-8848-9fba899b240b.png)

See ya, ToDo Item \#2! One final thing we'll try is changing one of our existing ToDo Items...

Running this command will change the `completed` state of ToDo Item \#3:

```graphql
mutation{
  updateTodo(input: {id: "3", completed: true}){
          id
          name
          completed
        }
}
```

Give it a try! We should see the `completed` field updated to `true` in DynamoDB:

![image](https://user-images.githubusercontent.com/4291961/116001465-93fcf880-a5c2-11eb-8d1b-4d81af8d2579.png)

Now that we've exercised our new GraphQL API, let's get back to the code and really start jamming!

### 3.6. Back to that Boring ToDo App...
Jumping back into the code, we need to setup our Flutter project so that it can use the Amplify Flutter SDK to communicate with our new backend service.

First open the `pubspec.yaml` file for the project... and make sure that the following have been added to our project's `dev_dependencies`:

```yaml
...

dev_dependencies:
...

  amplify_flutter: '<1.0.0'
  amplify_api: '<1.0.0'
...
```

Once saved, run the command `flutter pub get` to install the new packages.

Next we'll need to add the Amplify SDK and API Plugin packages to our application. 

Let's start by openning the `lib/main.dart` file...

First, add the amplify packages and configuration imports...

```dart
...

// Amplify packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';


// Amplify configuration
import 'amplifyconfiguration.dart';

...
```

Now, we just need to initialize the Amplify SDK in our app which can be done by adding the following to `main.dart` in the StateProvider's initializer:

```dart
...
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
...
```

This adds the AmplifyAPI plugin and bootstraps our AmplifySDK configuration provided in the `amplifyconfiguration.dart` file that the Amplify CLI generated for our application.

If we run the command `flutter run -d {device-name}` we should see the following output on startup telling us that the Amplify SDK has been properly initialized:

```
...
✓ Built build/app/outputs/flutter-apk/app-debug.apk.
Installing build/app/outputs/flutter-apk/app.apk...              2,382ms
I/flutter ( 9374): Amplify successfully configured!!!                   
...
```

Outstanding! The Amplify Flutter SDK is ready to start talking with our new back-end service... Let's give it a spin!

### 3.7. Next Step...
1. Checkout the branch `04-01-amplify-add-api`
2. Open the README.md in that branch at [4. "Jammin' with our Amplified GraphQL Service](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/04-wire-list-todos-api/README.md#4-jammin-with-our-amplified-graphql-service)
