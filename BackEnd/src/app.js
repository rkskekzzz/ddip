import express from 'express';

import config from './config/index.js';
import { Sequelize } from './models/database.js';
import routes from './routes/index.js';

import swaggerLoader from './loaders/swagger.js';
import expressLoader from './loaders/express.js'
import errorLoader from './loaders/error.js';

const app = express();

app.use('/api/docs', ...swaggerLoader)
app.use(...expressLoader)

app.use('/api', routes());

app.use(...errorLoader)

Sequelize.sync()

app.listen(config.host.port)