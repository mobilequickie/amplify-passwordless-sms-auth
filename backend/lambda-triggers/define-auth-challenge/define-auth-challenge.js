// ### About this Flow ###
// Using Custom Auth Flow through Amazon Cognito User Pools with Lambda Triggers to complete a 'CUSTOM_CHALLENGE'. This is the same flow as one-time passcode generated and sent via SMS or Email. 
// Instead, the service and user share a secret that was created during registration and both generate a 6-digit code based on the shared secret. 
// If the two codes (typically only good for 30 seconds) match, the user is authenticated.
//
// ### About this function ###
// This DefineAuthChallengeCustom function (1st and 4th of 4 triggers) defines the type of challenge-response required for authentication. 
// For HOTP, TOTP, U2F, or WebAuthn flows, we'll always use 'CUSTOM_CHALLENGE' and this function code won't change between the various auth methods.

// ### Next steps ###
// Updated: June 12, 2020

'use strict';

exports.handler = async (event) => {
    console.log('RECEIVED event: ', JSON.stringify(event, null, 2));
    
    // The first auth request for CUSTOM_CHALLENGE from the AWSMobileClient (in iOS native app) actually comes in as an "SRP_A" challenge (BUG in AWS iOS SDK), so switch to CUSTOM_CHALLENGE and clear session.
    if (event.request.session && event.request.session.length && event.request.session.slice(-1)[0].challengeName == "SRP_A") {
        console.log('New CUSTOM_CHALLENGE', JSON.stringify(event, null, 2));
        event.request.session = []; 
        event.response.issueTokens = false;
        event.response.failAuthentication = false;
        event.response.challengeName = 'CUSTOM_CHALLENGE';
    } 
    // User successfully answered the challenge, succeed with auth and issue OpenID tokens
    else if (event.request.session &&
        event.request.session.length &&
        event.request.session.slice(-1)[0].challengeName === 'CUSTOM_CHALLENGE' &&
        event.request.session.slice(-1)[0].challengeResult === true) {
        
        console.log('The user provided the right answer to the challenge; succeed auth');
        event.response.issueTokens = true;
        event.response.failAuthentication = false;
    }
    // After 3 failed challenge responses from user, fail authentication
    else if (event.request.session && event.request.session.length >= 4 && event.request.session.slice(-1)[0].challengeResult === false) {
        console.log('FAILED Authentication: The user provided a wrong answer 3 times');
        event.response.issueTokens = false;
        event.response.failAuthentication = true;
    } 
    // The user did not provide a correct answer yet; present CUSTOM_CHALLENGE again
    else {
        console.log('User response incorrect: Attempt [' + event.request.session.length + ']');
        event.response.issueTokens = false;
        event.response.failAuthentication = false;
        event.response.challengeName = 'CUSTOM_CHALLENGE';
    }
    
    console.log('RETURNED event: ', JSON.stringify(event, null, 2));
    
    return event;
};
