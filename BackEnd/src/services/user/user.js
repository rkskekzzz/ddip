import { UserModel } from "../../model/index.js";
import ApiError from "../../modules/error.js"

async function getUser(id) {
    const user = await UserModel.getById(id)

    if (!user) throw new ApiError(404, `User not found: ${id}`)

    return user
}

async function createUser(name) {
    const user = await UserModel.create(name);

    return user
}

async function updateUser(id, name) {
    const user = await UserModel.getById(id);
    if (!user) throw new ApiError(404, `User not found: ${id}`)

    const updated = await UserModel.update(id, name);

    return updated
}

async function deleteUser(id) {
    const user = await UserModel.getById(id);
    if (!user) throw new ApiError(404, `User not found: ${id}`)

    await UserModel.remove(id);
}

export default {
    getUser,
    createUser,
    updateUser,
    deleteUser
}