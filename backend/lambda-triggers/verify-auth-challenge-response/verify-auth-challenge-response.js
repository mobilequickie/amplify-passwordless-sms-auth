// ### About this Flow ###
// Using Custom Auth Flow through Amazon Cognito User Pools with Lambda Triggers to complete a 'CUSTOM_CHALLENGE'. This custom challenge is using
// a randomly generated 6-digit sent to the user via SMS using Amazon SNS. 
//
// ### About this function ###
// This VerifyAuthChallengeSMS function (3rd of 4 triggers) takes the user's 6-digit code sent via event.request.challengeAnswer parameter
// and returns TRUE if the user's passCode matches event.request.privateChallengeParameters.passCode.

// ### Next steps ###
'use strict';

exports.handler = async (event) => {
    console.log('RECEIVED Event: ', JSON.stringify(event, null, 2));
    
    let expectedAnswer = event.request.privateChallengeParameters.passCode || null;
    
    if (event.request.challengeAnswer === expectedAnswer) {
        event.response.answerCorrect = true;
    }
    else {
        event.response.answerCorrect = false;
    }
    
    console.log('RETURNED Event: ', JSON.stringify(event, null, 2));
    
    return event;
};