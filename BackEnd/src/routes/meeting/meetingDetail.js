import express from 'express';
import 'express-async-errors';

import MeetingDetailController from '../../controller/meeting/meetingDetail.js';

const router = express.Router();

router.get('/', MeetingDetailController.getMeetingDetail);
router.put('/', MeetingDetailController.updateMeetingDetail);

export default router;