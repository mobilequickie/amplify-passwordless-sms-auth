# Amplify Passwordless SMS Authentication

This serverless application is a passwordless SMS authentication solution for mobile and web application developers. It provisions a Amazon Cognito user pools custom auth challenge using AWS Lambda triggers and  Amazon SNS for sending secret codes via SMS.
 
![Lambda Triggers Diagram](https://docs.aws.amazon.com/cognito/latest/developerguide/images/lambda-challenges.png)

## Here's what this application is building

- An Amazon Cognito user pool, pre-configured with AWS Lambda triggers to implement the [custom authentication challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html) for passwordless SMS auth flow.
- An Amazon Cognito user pool client
- Four(4) Lambda functions running Node.js (v8.10) that serve as User Pool triggers to complete the custom authentication challenge auth flow
- Permissions for the Lambda function triggers to be invoked by your Cognito user pool and for the Lambda functions to publish to SNS to send SMS text messages.

## Amplify Passwordless SMS Authentication Solution Provides: ##

1. This backend application that deploys the resources listed above.
2. A sample [Web Client (Angular)](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/webClient/angular) app that demonstrates sign-up and sign-in of users via their phone number. The web client is an Angular 7 app that connects to your backend that was deployed via this serverless application.
3. A sample [iOS Mobile Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient) that demonstrates the ability to sign-up and sign-in a user via their phone number, straight from a native mobile app. 

Once you deploy this backend configuration. Setup the provided web client (Angular) or iOS app to demonstrate sign-up and sign-in of users, using only their phone number. 

[Web Client (Angular)](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/webClient/angular)

[iOS Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient)

### License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.
