import MeetingPinService from '../../services/meeting/meetingPin.js'

async function getMeetingPin(req, res, next) {
    const { id } = req.params

    const pin = await MeetingPinService.getMeetingPin(id)

    res.status(200).json(pin);
}

async function updateMeetingPin(req, res, next) {
    const { id } = req.params
    const {
        latitude,
        longitude,
        type,
        state
    } = req.body

    const pin = await MeetingPinService.updateMeetingPin(
        id,
        latitude,
        longitude,
        type,
        state
    )

    res.status(200).json(pin);
}

export default {
    getMeetingPin,
    updateMeetingPin
}