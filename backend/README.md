# Amplify Passwordless SMS Authentication - Backend

This is the source code used to build the backend Serverless Application Repository. 

### Deploy via the [Serverless Application Repository](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:552623489034:applications~amplify-passwordless-sms-auth) now.

#### Here's what the Serverless Application Repository will buid for you: 
- An Amazon Cognito user pool, pre-configured with AWS Lambda triggers to implement the [custom authentication challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html) for passwordless SMS auth flow.
- An Amazon Cognito user pool client.
- Four(4) Lambda functions running Node.js (v8.10) that serve as user pool triggers to complete the custom challenge auth flow
- Permissions for the Lambda function triggers to be invoked by your Cognito user pool and permission for Lambda to publish to SNS for sending secret codes via SMS.

Once you deploy this backend. Setup the provided web client (Angular) or iOS app to demonstrate sign-up and sign-in of users, using only their phone number. 

## Clients

[Web Client (Angular)](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/webClient/angular)

[iOS Client](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/iOSClient)

### License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.
