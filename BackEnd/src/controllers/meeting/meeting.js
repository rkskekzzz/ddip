import MeetingService from '../../services/meeting/meeting.js'

async function createMeeting(req, res, next) {
    const {
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
    } = req.body

    const meeting = await MeetingService.createMeeting(
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
    )

    res.status(200).json(meeting);
}

async function deleteMeeting(req, res, next) {
    const { id } = req.params

    await MeetingService.deleteMeeting(id)

    res.sendStatus(200)
}

export default {
    createMeeting,
    deleteMeeting
}