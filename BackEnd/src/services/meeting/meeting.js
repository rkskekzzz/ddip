import { MeetingDetailModel } from "../../model/index.js";
import { MeetingPinModel } from "../../model/index.js";
import ApiError from "../../modules/error.js"

// TODO: check all transaction is well conform
async function createMeeting(
    title,
    content,
    start_time,
    end_time,
    address,
    address_detail,
    max_attendee,
    latitude,
    longitude,
    type,
    state
) {
    const detail = await MeetingDetailModel.create(
        title,
        content,
        start_time,
        end_time,
        address,
        address_detail,
        max_attendee
    );
    const pin = await MeetingPinModel.create(
        latitude,
        longitude,
        type,
        state
    );

    return {detail, pin}
}

async function deleteMeeting(id) {
    const detail = await MeetingDetailModel.getById(id);
    const pin = await MeetingPinModel.getById(id);

    if (!detail && !pin) throw new ApiError(404, `Meeting not found: ${id}`)

    await MeetingDetailModel.remove(id);
    await MeetingPinModel.remove(id);
}

export default {
    createMeeting,
    deleteMeeting
}