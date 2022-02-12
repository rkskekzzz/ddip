import express from 'express';
import 'express-async-errors';

import MeetingDetailController from '../../controllers/meeting/meetingDetail.js';

const router = express.Router();

router.get('/', MeetingDetailController.getMeetingDetail);
router.put('/', MeetingDetailController.updateMeetingDetail);

export default router;