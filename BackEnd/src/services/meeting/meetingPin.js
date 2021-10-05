import { MeetingPinModel } from "../../model/index.js";
import ApiError from "../../modules/error.js"

async function getMeetingPin(id) {
    const pin = await MeetingPinModel.getById(id)

    if (!pin) throw new ApiError(404, `Meeting not found: ${id}`)

    return pin
}

async function updateMeetingPin(
    id,
    latitude,
    longitude,
    type,
    state
) {
    const pin = await MeetingPinModel.getById(id);
    if (!pin) throw new ApiError(404, `Meeting not found: ${id}`)

    const updated = await MeetingPinModel.update(
        id,
        latitude,
        longitude,
        type,
        state
    );

    return updated
}

export default {
    getMeetingPin,
    updateMeetingPin
}