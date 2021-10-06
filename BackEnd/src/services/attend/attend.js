import { AttendModel } from "../../models/index.js";
import ApiError from "../../modules/error.js"

async function getUserAttend(user_id) {
    const attends = await AttendModel.getByUserId(user_id)

    return attends
}

async function getMeetingAttend(meeting_id) {
    const attends = await AttendModel.getByMeetingId(meeting_id)

    return attends
}

// TODO: change state code
async function createAttend(user_id, meeting_id) {
    const attend = await AttendModel.getById(user_id, meeting_id);
    if (attend) throw new ApiError(404, `Already attended`)

    const newattend = await AttendModel.create(user_id, meeting_id);

    return newattend
}

async function deleteAttend(user_id, meeting_id) {
    const attend = await AttendModel.getById(user_id, meeting_id);
    if (!attend) throw new ApiError(404, `Attend not found: ${id}`)

    await AttendModel.remove(user_id, meeting_id);
}

export default {
    getUserAttend,
    getMeetingAttend,
    createAttend,
    deleteAttend
}