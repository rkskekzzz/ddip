import { Sequelize, DataTypes } from '../database.js'

const User = Sequelize.define(
    'user',
    {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            allowNull: false,
            primaryKey: true,
        },
        name: {
            type: DataTypes.STRING,
            allowNull: false,
        }
    },
    {
        freezeTableName: true,
        underscored: true
    }
);

async function getById(id) {
    return User.findOne({
        where: { id },
    });
}

async function create(name) {
    return User.create({ name })
        .then((data) => this.getById(data.dataValues.id));
}

async function update(id, name) {
    return User.findByPk(id)
        .then((user) => {
            user.name = name;
            return user.save()
                .then((data) => this.getById(data.dataValues.id));
        });
}

async function remove(id) {
    return User.findByPk(id)
        .then((user) => user.destroy())
}

export default {
    getById,
    create,
    update,
    remove,
}
