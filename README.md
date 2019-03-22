# Amplify Passwordless SMS Authentication

This is your passwordless SMS authentication solution for AWS. It uses Amazon Cognito user pools custom auth challenge with AWS Lambda triggers as shown in this diagram.
 
![Lambda Triggers Diagram](https://docs.aws.amazon.com/cognito/latest/developerguide/images/lambda-challenges.png)

## This repo provides: ##
1. The backend source configuration to deploy a fully functional passwordless SMS backend solution via this [AWS Serverless Repository](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:552623489034:applications~amplify-passwordless-sms-auth).
2. A sample [Web Client (Angular)](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/webClient/angular) app that demonstrates sign-up and sign-in of users via their phone number. The web client is an Angular 7 app that connects to your backend that was deployed via the AWS serverless repository.
3. A sample [iOS Mobile Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient) that demonstrates the ability to sign-up and sign-in a user via their phone number, straight from a native mobile app. 
4. (OPTIONAL) A walkthrough of installing the Amplify CLI, provisioning Amazon Pinpoint, and enabling the SMS channel of Pinpoint for sending the secret codes via SMS to your users. 

Here's what the [/backend](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/backend) solution builds with the AWS Serverless Repository:

- An Amazon Cognito user pool, pre-configured with AWS Lambda triggers to implement the [custom authentication challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html) for passwordless SMS auth flow.
- An Amazon Cognito user pool client
- Four(4) Lambda functions running Node.js (v8.10) that serve as User Pool triggers to complete the custom authentication challenge auth flow
- Permissions for the Lambda function triggers to be invoked by your Cognito user pool.

An example iOS client app that is ready to run against this Serverless Application can be found at [iOS Mobile Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient)

## Backend Deployment instructions

Deploy the backend through the Serverless Application Repository. 

#### Part I ###
1. Log into the AWS Lambda Console
2. Select create new function
3. Find the Serverless Application in the [Serverless Application Repository](https://console.aws.amazon.com/serverlessrepo/) using tags "passwordless" and "sms" or navigate to it directly [Amplify Passwordless SMS Authentication](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:552623489034:applications~amplify-passwordless-sms-auth).

Once you deploy this backend configuration. Setup the provided web client (Angular) or iOS app to demonstrate sign-up and sign-in of users, using only their phone number. 

[Web Client (Angular)](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/webClient/angular)

[iOS Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient)


### License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.
