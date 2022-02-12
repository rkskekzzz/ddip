import express from 'express';
import 'express-async-errors';

import MeetingPinController from '../../controllers/meeting/meetingPin.js';

const router = express.Router();

router.get('/', MeetingPinController.getMeetingPin);
router.put('/', MeetingPinController.updateMeetingPin);

export default router;