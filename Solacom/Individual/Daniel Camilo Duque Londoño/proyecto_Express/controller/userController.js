import { userModel } from "../model/userModel.js";

export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let usuarios = await userModel.find()
        respuesta.status(200).render("index", { usuarios })
    } catch (error) {
        console.log(error);
    }
}
export const crearDatos = async (peticion, respuesta) => {
    try {
        let data = peticion.body
        // Guardar datos
        await userModel.create(data)
        // devuelve la vista al usuario para vea los nuevos datos
        let usuarios = await userModel.find()
        respuesta.status(200).render("index", {usuarios})
    } catch (error) {
        console.log(error);
    }
}