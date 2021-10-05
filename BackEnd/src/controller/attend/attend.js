import AttendService from '../../services/attend/attend.js'

async function getAttend(req, res, next) {
    const { user_id, meeting_id } = req.params

    const attends = await ( user_id
        ? AttendService.getUserAttend(user_id)
        : AttendService.getMeetingAttend(meeting_id)
    )

    res.status(200).json(attends);
}

async function createAttend(req, res, next) {
    const { user_id, meeting_id } = req.body;

    const attend = await AttendService.createAttend(user_id, meeting_id)

    res.status(200).json(attend);
}

async function deleteAttend(req, res, next) {
    const { user_id, meeting_id } = req.params

    await AttendService.deleteAttend(user_id, meeting_id)

    res.sendStatus(200)
}

export default {
    getAttend,
    createAttend,
    deleteAttend,
}
