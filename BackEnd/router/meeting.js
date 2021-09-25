import express from 'express';
import 'express-async-errors';
import { body } from 'express-validator';
import * as meetingController from '../controller/meeting.js';
import { validate } from '../middleware/validator.js';

const router = express.Router();

const validateMeeting = [
  body('text')
    .trim()
    .isLength({ min: 3 })
    .withMessage('text should be at least 3 characters'),
  validate,
];

// GET /meeting
router.get('/', meetingController.getMeeting);

// GET /meeting/:id
router.get('/:id', meetingController.getMeeting);

// POST /meeting
router.post('/', meetingController.createMeeting);

// PUT /meeting/:id
router.put('/:id', meetingController.updateMeeting);

// DELETE /meeting/:id
router.delete('/:id', meetingController.deleteMeeting);

export default router;
