# Welcome to Amp'd Up Flutter Development with AWS Amplify!

![image](https://user-images.githubusercontent.com/4291961/114327253-47b3b200-9b06-11eb-837e-f62b032ff927.png)


<!-- This section to be in 03-amplify-add-api -->
## 3. "Amplifying" our ToDo App
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
1. **Next Step:**
	1. Checkout the branch `04-01-amplify-add-api`
	2. Open the README.md in that branch at [4. "Jammin' with our Amplified GraphQL Service]()
**TODO: Link to Section**
