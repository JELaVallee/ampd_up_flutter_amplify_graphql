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

Show the generated ToDo Schema artifacts

Add the `completed` field...

### 3.3. Deploy the New API!
Run command `amplify push api`

Explain the CloudFormation output

### 3.4. Exploring our New API 
Run command `amplify api console`

Walk through the wiring on the AWS side of things...

1. Start at the Amplify API Console
1. Drill down to the AppSync-GraphQL Console
1. Show and explain the GraphQL Resolvers
1. Go back to the Amplify API Console
1. Drill down to the DynamoDB Console
1. Show and explain the Dynamo ToDo record set

### 3.4. Talk to GraphQL interface with Altair GraphQL Client

1. Explain the Altair GraphQL Client interface
    1. Retrieve the GQL Catalog
    1. Explain the various Schema interfaces that were returned
1. List ToDo items [GraphQL Snippet](#graphql-query-to-list-the-todos)
1. Insert a ToDo item [GraphQL Snippet](#graphql-query-to-create-a-new-todo)
1. Change the completed state of a ToDo item [GraphQL Snippet](#graphql-query-to-mutate-a-todo)
1. Delete a ToDo item [GraphQL Snippet](#graphql-query-to-delete-a-todo)

### 3.5. Back to that Boring ToDo App...
Open the `pubspec.yaml` file for the project...

1. Add the `amplify_flutter` packages we're going to need to import
1. Run the command `flutter pub get` to add the packages to your environment

Open the `lib/main.dart` file...

1. Add the amplify packages and configuration imports
2. **TODO: Snippet of the import Code**
3. Add the `Amplify.API` plugin to the Init logic
4. **TODO: Snippet of the Init Code**

### 3.6. Next Step...

1. Checkout the branch `04-01-amplify-add-api`
2. Open the README.md in that branch at [4. "Jammin' with our Amplified GraphQL Service](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/04-wire-list-todos-api/README.md#4-jammin-with-our-amplified-graphql-service)
