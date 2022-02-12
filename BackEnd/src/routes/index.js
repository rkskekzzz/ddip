import { Router } from 'express';

import MeetingRouter from './meeting/meeting.js';
import AttendRouter from './attend/attend.js';
import UserRouter from './user/user.js';

export default () => { 
    const router = Router();

    router.use('/meeting', MeetingRouter);
    router.use('/attend', AttendRouter);
    router.use('/user', UserRouter);

    return router
};