import SQ from 'sequelize';
import { sequelize } from '../db/database.js';
const DataTypes = SQ.DataTypes;
const Sequelize = SQ.Sequelize;

const pin = sequelize.define('pin', {
    id: {
        type: DataTypes.UUID,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false,
        primaryKey: true,
    },
    latitude: {
        type: DataTypes.DOUBLE,
        allowNull: false,
    }, 
    longitude: {
        type: DataTypes.DOUBLE,
        allowNull: false,
    },
});
