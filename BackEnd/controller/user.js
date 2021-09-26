import { Pin } from '../model/pin.js';
import { Meeting } from '../model/meeting.js';
import { User } from '../model/user.js';
import { Attend } from '../model/attend.js';

export async function getUser(req, res, next) {
    res.status(200).send("getUser")
}

export async function createUser(req, res, next) {
    res.status(200).send("createUser")
}

export async function updateUser(req, res, next) {
    res.status(200).send("createUser")
}

export async function deleteUser(req, res, next) {
    res.status(200).send("createUser")
}
