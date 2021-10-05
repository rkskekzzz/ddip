import express from 'express';
import 'express-async-errors';

import AttendController from '../../controller/attend/attend.js';

const router = express.Router();

router.get('/', AttendController.getAttend);
router.post('/', AttendController.createAttend);
router.delete('/', AttendController.deleteAttend);

export default router