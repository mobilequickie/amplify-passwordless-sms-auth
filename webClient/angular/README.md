# Amplify Passwordless SMS Auth WebClient (Angular)

This is a client web app that provides custom passwordless sign-up and sign-in pages to authenticate against Amazon Cognito user pools custom authentication Lambda triggers that was deployed via the serverless repository followed the [/backend](https://github.com/dennisAWS/amplify-passwordless-sms-auth/tree/master/backend) instructions.

If you are interested in [passwordless email authentication](https://github.com/aws-samples/amazon-cognito-passwordless-email-auth/tree/master/cognito)
## How to run this web app

### Pre-requisites

1. Download and install [Node.js](https://nodejs.org/en/download/)
2. Set up [/backend](https://github.com/dennisAWS/amplify-passwordless-sms-auth/tree/master/backend) as described.

### Run the web app

1. Clone this repo 
`git clone https://github.com/dennisAWS/amplify-passwordless-sms-auth.git`
2. Enter webClient directory: `cd webClient/angular/`
3. Install dependencies: `npm install`
4. Enter your AWS region, Cognito user pool ID and your Web App Client ID in this file: `src/environments/environment.ts`. You can get this information from the CloudFormation stack outputs of the Cognito user pool created in [/backend](https://github.com/dennisAWS/amplify-passwordless-sms-auth/tree/master/backend)
5. Run the web app locally: `npm run start`

The web app client should be running at http://localhost:4200 allowing you to register a new user with full name and phone number and login with only the registered phone number.

### License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.
