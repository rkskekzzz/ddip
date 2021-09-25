import SQ from 'sequelize';
import { sequelize } from '../db/database.js';
const DataTypes = SQ.DataTypes;
const Sequelize = SQ.Sequelize;

const meeting = sequelize.define('meeting', {
    id: {
        type: DataTypes.UUID,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false,
        primaryKey: true,
    },
    title: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    text: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
    start: {
        type: DataTypes.
    },,
    e
    address: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    address_detail: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    attendee {
        type: DataTypes.IINTEGER
        allowNull: false,
    }
});
