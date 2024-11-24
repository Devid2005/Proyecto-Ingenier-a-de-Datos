import { productoModel } from '../model/productoModel.js';

export const obtenerProducto = async(peticion,respuesta) =>{
    try{
        let producto = await productoModel.find()
        respuesta.status(200).json({ producto : producto})
    } catch(error){
        console.log(error);
    }
}

export const CrearProducto = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await productoModel.create(data)
        // devuelva como una vista 
        let producto = await productoModel.find()
        respuesta.status(200).json({ productoModel: producto})
    } catch(error){
        console.log(error)
    }
}

export const EditarProducto = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        const productoEditado = await productoModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'producto actualizado correctamente', producto:productoEditado})
    } catch(error){
        console.log(error)
    }
}
export const EliminarProducto = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        const productoEliminado = await productoModel.findByIdAndDelete(id);
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'producto eliminado correctamente', producto:productoEliminado})
    } catch(error){
        console.log(error)
    }
}
