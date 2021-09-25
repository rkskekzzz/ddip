import * as meetingModel from '../model/pin.js';

export async function getMeeting(req, res, next) {
    res.status(200).send("getMeeting")
}

export async function createMeeting(req, res, next) {
    res.status(200).send("createMeeting")
}

export async function updateMeeting(req, res, next) {
    res.status(200).send("createMeeting")
}

export async function deleteMeeting(req, res, next) {
    res.status(200).send("createMeeting")
}
