import { Sequelize, DataTypes } from '../database.js'

const MeetingDetail = Sequelize.define(
    'meeting_detail',
    {
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
        content: {
            type: DataTypes.TEXT,
            allowNull: false,
        },
        start_time: {
            type: DataTypes.TIME,
            allowNull: false,
        },
        end_time: {
            type: DataTypes.TIME,
            allowNull: false,
        },
        address: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        address_detail: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        max_attendee: {
            type: DataTypes.INTEGER,
            allowNull: false,
        }
    },
    {
        freezeTableName: true,
        underscored: true
    }
);

async function getById(id) {
    return MeetingDetail.findOne({
        where: { id },
    });
}

async function create(
    title,
    content,
    start_time,
    end_time,
    address,
    address_detail,
    max_attendee
) {
    return MeetingDetail.create({
        title,
        content,
        start_time,
        end_time,
        address,
        address_detail,
        max_attendee
    })
    .then((data) => this.getById(data.dataValues.id));
}

async function update(
    id,
    title,
    content,
    start_time,
    end_time,
    address,
    address_detail,
    max_attendee
) {
    return MeetingDetail.findByPk(id)
        .then((detail) => {
            detail.title = title
            detail.content = content
            detail.start_time = start_time
            detail.end_time = end_time
            detail.address = address
            detail.address_detail = address_detail
            detail.max_attendee = max_attendee
            return detail.save()
                .then((data) => this.getById(data.dataValues.id));
        })
}

async function remove(id) {
    return MeetingDetail.findByPk(id)
        .then((meeting) => meeting.destroy())
}

export default {
    getById,
    create,
    update,
    remove,
}