import SQ from 'sequelize';
import { sequelize } from '../db/database.js';
import { Meeting } from './meeting.js';
const DataTypes = SQ.DataTypes;
const Sequelize = SQ.Sequelize;

export const Pin = sequelize.define(
    'pin',
    {
        id: {
            type: DataTypes.UUID,
            defaultValue: Sequelize.UUIDV4,
            allowNull: false,
            primaryKey: true,
            references: {
                model: 'meeting',
                key: 'id',
            }
        },
        latitude: {
            type: DataTypes.DOUBLE,
            allowNull: false,
        },
        longitude: {
            type: DataTypes.DOUBLE,
            allowNull: false,
        },
        type: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        state: {
            type: DataTypes.INTEGER,
            allowNull: false,
        }
    },
    {
        freezeTableName: true,
        timestamps: false
    }
);
// Pin.belongsTo(Meeting, {
//     foreignKey: {
//       name: 'meeting_id',
//       primaryKey: true,
//     }
//   });
