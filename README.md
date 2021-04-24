# Welcome to Amp'd Up Flutter Development with AWS Amplify!

![image](https://user-images.githubusercontent.com/4291961/114327253-47b3b200-9b06-11eb-837e-f62b032ff927.png)

<!-- This section to be in 02-amplify-init -->
## 2. Configure: Initialize Amplify
### 2.1. Initialize the Project
Before we can Amp Up this boring ToDo App, we first need to initialize the Amplify project. Run the following command in the _root_ of the project:

```
$ amplify init
```

This will walk you through a setup wizard... For this demo, use the following values:

```
? Enter a name for the project ampduptest01
The following configuration will be applied:

Project information
| Name: ampduptest01
| Environment: dev
| Default editor: Visual Studio Code
| App type: flutter
| Configuration file location: ./lib/

? Initialize the project with the above configuration? Yes
Using default provider  awscloudformation
? Select the authentication method you want to use: AWS access keys
? accessKeyId:  ********************
? secretAccessKey:  ****************************************
? region:  us-east-1
```

Once those values have been added, Amplify will initialize your project and automatically scaffold your Amplify cloud environment:

```
Adding backend environment dev to AWS Amplify Console app: d2ceeix26aics2
⠏ Initializing project in the cloud...

CREATE_IN_PROGRESS amplify-ampduptest01-dev-144947 AWS::CloudFormation::Stack Sat Apr 24 2021 14:49:50 GMT-0400 (Eastern Daylight Time) User Initiated             
CREATE_IN_PROGRESS DeploymentBucket                AWS::S3::Bucket            Sat Apr 24 2021 14:49:55 GMT-0400 (Eastern Daylight Time)                            
CREATE_IN_PROGRESS AuthRole                        AWS::IAM::Role             Sat Apr 24 2021 14:49:55 GMT-0400 (Eastern Daylight Time)                            
CREATE_IN_PROGRESS UnauthRole                      AWS::IAM::Role             Sat Apr 24 2021 14:49:55 GMT-0400 (Eastern Daylight Time)                            
CREATE_IN_PROGRESS UnauthRole                      AWS::IAM::Role             Sat Apr 24 2021 14:49:55 GMT-0400 (Eastern Daylight Time) Resource creation Initiated
CREATE_IN_PROGRESS DeploymentBucket                AWS::S3::Bucket            Sat Apr 24 2021 14:49:55 GMT-0400 (Eastern Daylight Time) Resource creation Initiated
CREATE_IN_PROGRESS AuthRole                        AWS::IAM::Role             Sat Apr 24 2021 14:49:55 GMT-0400 (Eastern Daylight Time) Resource creation Initiated
⠴ Initializing project in the cloud...

CREATE_COMPLETE UnauthRole AWS::IAM::Role Sat Apr 24 2021 14:50:07 GMT-0400 (Eastern Daylight Time) 
CREATE_COMPLETE AuthRole   AWS::IAM::Role Sat Apr 24 2021 14:50:07 GMT-0400 (Eastern Daylight Time) 
⠏ Initializing project in the cloud...

CREATE_COMPLETE DeploymentBucket                AWS::S3::Bucket            Sat Apr 24 2021 14:50:16 GMT-0400 (Eastern Daylight Time) 
CREATE_COMPLETE amplify-ampduptest01-dev-144947 AWS::CloudFormation::Stack Sat Apr 24 2021 14:50:18 GMT-0400 (Eastern Daylight Time) 
✔ Successfully created initial AWS cloud resources for deployments.
✔ Initialized provider successfully.
Initialized your environment successfully.

Your project has been successfully initialized and connected to the cloud!
```

### 2.2. What just happened?
Amplify has done two things here, added an initial configuration for your amplify project in `lib/amplifyconfig.dart` and added a new `amplify` directory where all of the "magic" will happen in subsequent steps.

If you run the command `$ amplify status` you should see the following:

```
$ amplify status

Current Environment: dev

| Category | Resource name | Operation | Provider plugin |
| -------- | ------------- | --------- | --------------- |

```

This shows us that we've successfully initialized our Amplify project, but currently have no services deployed. Let's do something about that!

### 2.3. Next Step...

1. Checkout the branch `03-amplify-add-api`
2. Open the README.md in that branch at [3. "Amplifying" our ToDo App](https://github.com/JELaVallee/ampd_up_flutter_amplify_graphql/blob/03-amplify-add-api/README.md#3-amplifying-our-todo-app)

