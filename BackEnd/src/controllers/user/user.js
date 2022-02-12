import UserService from '../../services/user/user.js'

async function getUser(req, res, next) {
    const { id } = req.params

    const user = await UserService.getUser(id)

    res.status(200).json(user);
}

async function createUser(req, res, next) {
    const { name } = req.body;

    const user = await UserService.createUser(name)

    res.status(200).json(user);
}

async function updateUser(req, res, next) {
    const { id } = req.params
    const { name } = req.body

    const user = await UserService.updateUser(id, name)

    res.status(200).json(user);
}

async function deleteUser(req, res, next) {
    const { id } = req.params

    await UserService.deleteUser(id)

    res.sendStatus(200)
}

export default {
    getUser,
    createUser,
    updateUser,
    deleteUser,
}
