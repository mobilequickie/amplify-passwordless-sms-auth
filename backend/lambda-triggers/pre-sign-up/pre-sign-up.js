"use strict";

exports.handler = async (event) => {
    event.response.autoConfirmUser = true;
    event.response.autoVerifyPhone = true;
    return event;
};
