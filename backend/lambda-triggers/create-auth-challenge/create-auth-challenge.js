"use strict";

const crypto_secure_random_digit = require("crypto-secure-random-digit");
const AWS = require("aws-sdk");

// Create a new Pinpoint object.
//var pinpoint = new AWS.Pinpoint();
var sns = new AWS.SNS();

// Get Pinpoint Project ID from environment variable
// var poinpointProjectID = process.env.PINPOINT_PROJECT_ID; 

// Main handler
exports.handler = async (event = {}) => {
    let secretLoginCode;
    if (!event.request.session || !event.request.session.length) {
        var phoneNumber = event.request.userAttributes.phone_number;
        // This is a new auth session
        // Generate a new secret login code and text it to the user
        secretLoginCode = crypto_secure_random_digit.randomDigits(6).join('');
        await sendSMSviaSNS(phoneNumber, secretLoginCode); // use SNS for sending SMS
        //await sendSMSviaPinpoint(phoneNumber, secretLoginCode); // use Amazon Pinpoint for sending SMS
    }
    else {
        // There's an existing session. Don't generate new digits but
        // re-use the code from the current session. This allows the user to
        // make a mistake when keying in the code and to then retry, rather
        // the needing to e-mail the user an all new code again.    
        const previousChallenge = event.request.session.slice(-1)[0];
        secretLoginCode = previousChallenge.challengeMetadata.match(/CODE-(\d*)/)[1];
    }
    // This is sent back to the client app
    event.response.publicChallengeParameters = { phone: event.request.userAttributes.phone_number };
    // Add the secret login code to the private challenge parameters
    // so it can be verified by the "Verify Auth Challenge Response" trigger
    event.response.privateChallengeParameters = { secretLoginCode };
    // Add the secret login code to the session so it is available
    // in a next invocation of the "Create Auth Challenge" trigger
    event.response.challengeMetadata = `CODE-${secretLoginCode}`;
    return event;
};

// Send secret code over SMS via Amazon Pinpoint SMS channel
// Requirements: An Amazon Pinpoint Application with SMS channel enabled
// async function sendSMSviaPinpoint(phoneNumber, secretLoginCode) {
//     const params = {
//         ApplicationId: poinpointProjectID,
//         MessageRequest: {
//             Addresses: {
//                 [phoneNumber]: {
//                     ChannelType: 'SMS'
//                 }
//             },
//             MessageConfiguration: {
//                 SMSMessage: {
//                     Body: secretLoginCode,
//                     MessageType: 'TRANSACTIONAL'
//                 }
//             }
//         }
//     };
//     await pinpoint.sendMessages(params).promise();
// }

// Send secret code over SMS via Amazon Simple Notification Service (SNS)
// Requirements: Permission for this function to publish to SNS 
async function sendSMSviaSNS(phoneNumber, secretLoginCode) {
    const params = { "Message": "[MobileQuickie] Your secret code: " + secretLoginCode, "PhoneNumber": phoneNumber };
    await sns.publish(params).promise();
}
