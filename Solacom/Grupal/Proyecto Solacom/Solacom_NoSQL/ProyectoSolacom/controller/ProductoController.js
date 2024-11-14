import { productoModel } from '../model/productoModel.js';

export const obtenerProductos = async(peticion,respuesta) =>{
    try{
        let producto = await productoModel.find()
        respuesta.status(200).render('index',{producto})
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
        respuesta.status(200).render('index',{producto})
    } catch(error){
        console.log(error)
    }
}

export const EditarProducto = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await productoModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let producto = await productoModel.find()
        respuesta.status(200).render('index',{producto})
    } catch(error){
        console.log(error)
    }
}

export const EliminarProducto = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await productoModel.findByIdAndDelete(id)
        // devuelva como una vista
        let producto = await productoModel.find()
        respuesta.status(200).render('index',{producto})
    } catch(error){
        console.log(error)
    }
}

