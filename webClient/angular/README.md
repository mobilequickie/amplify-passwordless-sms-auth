# Amplify Passwordless SMS Auth - WebClient (Angular)

This is a client web app that provides custom passwordless sign-up and sign-in pages to authenticate against an Amazon Cognito user pool via custom authentication challenge flow with Lambda triggers. 

## How to run this web app

### Pre-requisites to run this Angular web client

1. Download and install [Node.js](https://nodejs.org/en/download/)
2. Deploy backend via the AWS Serverless Application Repository as described in [/backend](https://github.com/mobilequickie/amplify-passwordless-sms-auth/tree/master/backend)

### Run the web client
Once the backend is deployed, run the web client to demonstrate the passwordless authentication flow via SMS.

1. Clone this repo 
`git clone https://github.com/mobilequickie/amplify-passwordless-sms-auth.git`
2. Enter webClient directory: `cd webClient/angular/`
3. Install dependencies: `npm install`
4. Enter your AWS region, Cognito user pool ID and your Web App Client ID in this file: `src/environments/environment.ts`. You can get this information from the CloudFormation stack outputs of the serverless repo deployment.
5. Run the web app locally: `npm run start`

The web app client should be running at http://localhost:4200 allowing you to register a new user with full name and phone number and login with only the registered phone number.

Once you have it running locally and tested, you can deploy this  directly to AWS Amplify Console:

[![amplifybutton](https://oneclick.amplifyapp.com/button.svg)](https://console.aws.amazon.com/amplify/home#/deploy?repo=https://github.com/mobilequickie/amplify-passwordless-sms-auth)

![Screenshot](one-click-console.gif)

### License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.