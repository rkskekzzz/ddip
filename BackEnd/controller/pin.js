import { Pin } from '../model/pin.js';
import { Meeting } from '../model/meeting.js';
import { User } from '../model/user.js';
import { Attend } from '../model/attend.js';

export async function getPin(req, res, next) {
    res.status(200).send("getPin")
}

export async function createPin(req, res, next) {
    res.status(200).send("createPin")
}

export async function updatePin(req, res, next) {
    res.status(200).send("createPin")
}

export async function deletePin(req, res, next) {
    res.status(200).send("createPin")
}
