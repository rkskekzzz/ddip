import { Pin } from '../model/pin.js';
import { Meeting } from '../model/meeting.js';
import { User } from '../model/user.js';
import { Attend } from '../model/attend.js';

export async function getAttend(req, res, next) {
    res.status(200).send("getMeeting")
}

export async function createAttend(req, res, next) {
    res.status(200).send("createAttend")
}

export async function deleteAttend(req, res, next) {
    res.status(200).send("createAttend")
}
