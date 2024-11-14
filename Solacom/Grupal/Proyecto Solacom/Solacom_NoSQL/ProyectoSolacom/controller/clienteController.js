import { clienteModel } from '../model/clienteModel.js';

export const obtenerClientes = async(peticion,respuesta) =>{
    try{
        let cliente = await clienteModel.find()
        respuesta.status(200).json({ cliente: cliente})
    } catch(error){
        console.log(error);
    }
}

export const Crearcliente = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await clienteModel.create(data)
        // devuelva como una vista 
        let cliente = await clienteModel.find()
        respuesta.status(200).json({ cliente: cliente})
    } catch(error){
        console.log(error)
    }
}

export const EditarCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await clienteModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let cliente = await clienteModel.find()
        respuesta.status(200).json({ cliente: cliente})
    } catch(error){
        console.log(error)
    }
}

export const EliminarCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await clienteModel.findByIdAndDelete(id)
        // devuelva como una vista
        let cliente = await clienteModel.find()
        respuesta.status(200).json({ cliente: cliente})
    } catch(error){
        console.log(error)
    }
}

