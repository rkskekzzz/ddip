import path from 'path'
import dotenv from 'dotenv';

const __dirname = path.resolve();
const env_file = process.env.NODE_ENV === "production" ? './env/prod.env' : './env/dev.env'
dotenv.config({ path: path.join(__dirname, env_file) })

export const config = {
    host: {
        port: process.env['HOST_PORT'],
    },
    db: {
        host: process.env['DB_HOST'],
        port: process.env['DB_PORT'],
        user: process.env['DB_USER'],
        database: process.env['DB_DATABASE'],
        password: process.env['DB_PASSWORD'],
    },
};
