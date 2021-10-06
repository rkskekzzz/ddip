import { Sequelize, DataTypes } from '../database.js'

const MeetingPin = Sequelize.define(
    'meeting_pin',
    {
        id: {
            type: DataTypes.UUID,
            defaultValue: Sequelize.UUIDV4,
            allowNull: false,
            primaryKey: true,
            references: {
                model: 'meeting_detail',
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
        createdAt: false,
        underscored: true
    }
);

async function getById(id) {
    return MeetingPin.findOne({
          where: { id },
    });
}

async function create(
    latitude,
    longitude,
    type,
    state
) {
    return MeetingPin.create({ latitude, longitude, type, state })
        .then((data) => this.getById(data.dataValues.id));
}

async function update(
    id,
    latitude,
    longitude,
    type,
    state
) {
    return MeetingPin.findByPk(id)
        .then((pin) => {
            pin.latitude = latitude;
            pin.longitude = longitude;
            pin.type = type;
            pin.state = state;
            return pin.save()
                .then((data) => this.getById(data.dataValues.id));
        });
}

async function remove(id) {
    return MeetingPin.findByPk(id)
        .then((pin) => {
            pin.destroy();
        })
}

export default {
    getById,
    create,
    update,
    remove,
}