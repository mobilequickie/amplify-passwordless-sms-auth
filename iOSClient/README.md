# Amplify Passwordless SMS Auth - iOS Swift App

This is a client mobile iOS Swift app that provides a custom passwordless sign-in page to authenticate against an Amazon Cognito user pool via custom authentication challenge flow with Lambda triggers. 

## How to run this iOS Sample App

### Pre-requisites to run the iOS app
Xcode and Cocoapods

### Run the iOS client
Once the backend is deployed, run this iOS app to demonstrate the passwordless authentication flow.

1. Clone this repo 
`git clone https://github.com/mobilequickie/amplify-passwordless-sms-auth.git`
2. Enter webClient directory: `cd iOSClient/`
3. Install Cocoapod dependencies: `pod install --repo-update`
4. Enter your AWS region, Cognito user pool ID and your Client ID in this file: `awsconfiguration.json`. You can get this information from the CloudFormation stack outputs of the serverless repo deployment.
5. Launch the iOS app via Xcode: `open CustomAuth.xcworkspace/`
6. Build and run the app on a real iOS device