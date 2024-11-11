import { productosModel } from '../model/productosModel.js';

export const obtenerProductos = async(peticion,respuesta) =>{
    try{
        let productos = await productosModel.find()
        respuesta.status(200).render('index',{productos})
    } catch(error){
        console.log(error);
    }
}

export const CrearProductos = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await productosModel.create(data)
        // devuelva como una vista 
        let productos = await productosModel.find()
        respuesta.status(200).render('index',{productos})
    } catch(error){
        console.log(error)
    }
}

export const EditarProductos = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await productosModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let productos = await productosModel.find()
        respuesta.status(200).render('index',{productos})
    } catch(error){
        console.log(error)
    }
}

export const EliminarProductos = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await productosModel.findByIdAndDelete(id)
        // devuelva como una vista
        let productos = await productosModel.find()
        respuesta.status(200).render('index',{productos})
    } catch(error){
        console.log(error)
    }
}

export const ProductosPorPrecio = async(peticion,respuesta) => {
    try{
        let precio = peticion.params.precio
        if (precio > 100){
        let productos = await productosModel.find({ precio: { $gte: precio } })
        respuesta.status(200).render('index',{ productos })
        } else {
            respuesta.status(404).send('Precio debe ser mayor a 100')
        }
    } catch(error){
        console.log(error)
    }
}

export const OrdenarProductosPorPrecio = async(peticion,respuesta) => {
    try{
        let orden = peticion.params.orden
        let productos = await productosModel.find().sort({ precio: orden })
        respuesta.status(200).render('index',{ productos })
    } catch(error){
        console.log(error)
    }
}