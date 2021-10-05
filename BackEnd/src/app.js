import express from 'express';

import config from './config/index.js';
import { Sequelize } from './model/database.js';
import routes from './routes/index.js';

import swaggerLoader from './loader/swagger.js';
import expressLoader from './loader/express.js'
import errorLoader from './loader/error.js';

const app = express();

app.use('/api/docs', ...swaggerLoader)
app.use(...expressLoader)

app.use('/api', routes());

app.use(...errorLoader)

Sequelize.sync()

app.listen(config.host.port)