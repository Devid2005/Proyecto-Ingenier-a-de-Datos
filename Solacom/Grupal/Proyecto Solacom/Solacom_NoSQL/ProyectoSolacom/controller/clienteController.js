import { clienteModel } from '../model/clienteModel.js';

export const obtenerCliente = async(peticion,respuesta) =>{
    try{
        let Cliente = await clienteModel.find()
        respuesta.status(200).json({ Cliente : Cliente})
    } catch(error){
        console.log(error);
    }
}

export const CrearCliente = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await clienteModel.create(data)
        // devuelva como una vista 
        let Cliente = await clienteModel.find()
        respuesta.status(200).json({ clienteModel: Cliente})
    } catch(error){
        console.log(error)
    }
}

export const EditarCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        const ClienteEditado = await clienteModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'Pedido de Cliente actualizado correctamente', Cliente:ClienteEditado})
    } catch(error){
        console.log(error)
    }
}
export const EliminarCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        const ClienteEliminado = await clienteModel.findByIdAndDelete(id);
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'Pedido de Cliente eliminado correctamente', Cliente:ClienteEliminado})
    } catch(error){
        console.log(error)
    }
}

