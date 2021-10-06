import express from 'express';
import 'express-async-errors';

import MeetingDetailRouter from './meetingDetail.js';
import MeetingPinRouter from './meetingPin.js';

import MeetingController from '../../controllers/meeting/meeting.js';

const router = express.Router();

router.post('/', MeetingController.createMeeting);
router.delete('/:id', MeetingController.deleteMeeting);

router.use('/detail', MeetingDetailRouter);
router.use('/pin', MeetingPinRouter);

export default router