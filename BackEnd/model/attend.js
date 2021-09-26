import SQ from 'sequelize';
import { sequelize } from '../db/database.js';
const DataTypes = SQ.DataTypes;
const Sequelize = SQ.Sequelize;

export const Attend = sequelize.define(
    'attend',
    {
        meeting_id: {
            type: DataTypes.UUID,
            defaultValue: Sequelize.UUIDV4,
            allowNull: false,
            primaryKey: true,
            references: {
                model: 'meeting',
                key: 'id',
            }
        },
        user_id: {
            type: DataTypes.UUID,
            defaultValue: Sequelize.UUIDV4,
            allowNull: false,
            primaryKey: true,
            references: {
                model: 'user',
                key: 'id',
            }
        },
    },
    {
        freezeTableName: true,
        underscored: true,
        updatedAt: false,
    }
);
