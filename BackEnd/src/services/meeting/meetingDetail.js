import { MeetingDetailModel } from "../../model/index.js";
import ApiError from "../../modules/error.js"

async function getMeetingDetail(id) {
    const detail = await MeetingDetailModel.getById(id)

    if (!detail) throw new ApiError(404, `Meeting not found: ${id}`)

    return detail
}

async function updateMeetingDetail(
    id,
    title,
    content,
    start_time,
    end_time,
    address,
    address_detail,
    max_attendee
) {
    const detail = await MeetingDetailModel.getById(id);
    if (!detail) throw new ApiError(404, `Meeting not found: ${id}`)

    const updated = await MeetingDetailModel.update(
        id,
        title,
        content,
        start_time,
        end_time,
        address,
        address_detail,
        max_attendee
    );

    return updated
}

export default {
    getMeetingDetail,
    updateMeetingDetail
}