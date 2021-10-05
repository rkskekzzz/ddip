import express from 'express';
import 'express-async-errors';

import UserController from '../../controller/user/user.js';
import { validateUser } from '../../middleware/validator/validateUser.js';
import { validateError } from '../../middleware/validator/validateError.js';
  
const router = express.Router();

router.get('/:id', UserController.getUser);
router.post('/', validateUser, validateError, UserController.createUser);
router.put('/:id', validateUser, validateError, UserController.updateUser);
router.delete('/:id', UserController.deleteUser);

export default router