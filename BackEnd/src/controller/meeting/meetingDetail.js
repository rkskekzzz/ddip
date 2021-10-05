import MeetingDetailService from '../../services/meeting/meetingDetail.js'

async function getMeetingDetail(req, res, next) {
    const { id } = req.params

    const detail = await MeetingDetailService.getMeetingDetail(id)

    res.status(200).json(detail);
}

async function updateMeetingDetail(req, res, next) {
    const { id } = req.params
    const {
        title,
        content,
        start_time,
        end_time,
        address,
        address_detail,
        max_attendee
    } = req.body

    const detail = await MeetingDetailService.updateMeetingDetail(
        id,
        title,
        content,
        start_time,
        end_time,
        address,
        address_detail,
        max_attendee
    )

    res.status(200).json(detail);
}

export default {
    getMeetingDetail,
    updateMeetingDetail
}