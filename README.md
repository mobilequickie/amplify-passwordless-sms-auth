# Amplify Passwordless SMS Authentication
This is your passwordless SMS authentication solution for AWS. It uses Amazon Cognito user pools custom auth challenge with AWS Lambda triggers as shown in this diagram.
 
![Lambda Triggers Diagram](https://docs.aws.amazon.com/cognito/latest/developerguide/images/lambda-challenges.png)

## This repo provides: ##
1. The backend source configuration to deploy a fully functional passwordless SMS backend solution via this [AWS Serverless Repository](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:552623489034:applications~amplify-passwordless-sms-auth).
2. A sample [Web Client (Angular)](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/webClient/angular) app that demonstrates sign-up and sign-in of users via their phone number. The web client is an Angular 7 app that connects to your backend that was deployed via the AWS serverless repository.
3. A sample [iOS Mobile Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient) that demonstrates the ability to sign-up and sign-in a user via their phone number, straight from a native mobile app. 

If you are interested in [passwordless email authentication](https://github.com/aws-samples/amazon-cognito-passwordless-email-auth/tree/master/cognito)

## Backend Deployment instructions

Deploy the backend through the Serverless Application Repository as outlined in [/backend](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/backend). 

Once you deploy this backend via the Serverless Application Repository, you can setup the provided web client (Angular) or iOS app to demonstrate sign-up and sign-in of users, using only their phone number. 

#### Clients ####

[Web Client (Angular)](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/webClient/angular)

[iOS Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient)

### License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.
