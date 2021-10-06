import { Sequelize, DataTypes } from '../database.js'

const Attend = Sequelize.define(
    'attend',
    {
        meeting_id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            allowNull: false,
            primaryKey: true,
            references: {
                model: 'meeting_detail',
                key: 'id',
            }
        },
        user_id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
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

async function getById(user_id, meeting_id) {
    return Attend.findOne({
        where: {
            user_id,
            meeting_id
        },
    });
}

async function getByMeetingId(meeting_id) {
    return Attend.findAll({
        where: { meeting_id },
    });
}

async function getByUserId(user_id) {
    return Attend.findAll({
        where: { user_id },
    });
}

async function create(user_id, meeting_id) {
    return Attend.create({ user_id, meeting_id })
        .then((data) => this.getById(data.dataValues.id));
}

async function remove(user_id, meeting_id) {
    return Attend.findOne({
        where: {
            user_id,
            meeting_id
        }
    }).then((user) => {
        user.destroy();
    })
}

export default {
    getById,
    getByMeetingId,
    getByUserId,
    create,
    remove,
}