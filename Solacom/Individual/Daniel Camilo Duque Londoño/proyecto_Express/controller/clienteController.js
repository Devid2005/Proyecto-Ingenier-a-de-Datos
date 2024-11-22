import { clienteModel } from "../model/clienteModel.js";

export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let clientes = await clienteModel.find()
        respuesta.status(200).render("index", { clientes })
    } catch (error) {
        console.log(error);
    }
}
export const crearDatos = async (peticion, respuesta) => {
    try {
        let data = peticion.body
        // Guardar datos
        await clienteModel.create(data)
        // devuelve la vista al usuario para vea los nuevos datos
        let clientes = await clienteModel.find()
        respuesta.status(200).render("index", {clientes})
    } catch (error) {
        console.log(error);
    }
}