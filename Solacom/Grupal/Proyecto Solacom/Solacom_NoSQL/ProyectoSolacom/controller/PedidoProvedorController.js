import { pedidoProvedorModel } from '../model/pedidoProvedorModel.js';

export const obtenerPedidoProvedor = async(peticion,respuesta) =>{
    try{
        let pedidoProvedor = await pedidoProvedorModel.find()
        respuesta.status(200).render('index',{pedidoProvedor})
    } catch(error){
        console.log(error);
    }
}

export const CrearpedidoProvedor = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await pedidoProvedorModel.create(data)
        // devuelva como una vista 
        let pedidoProvedor = await pedidoProvedorModel.find()
        respuesta.status(200).render('index',{pedidoProvedor})
    } catch(error){
        console.log(error)
    }
}

export const EditarPedidoProvedor = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await pedidoProvedorModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let pedidoProvedor = await pedidoProvedorModel.find()
        respuesta.status(200).render('index',{pedidoProvedor})
    } catch(error){
        console.log(error)
    }
}

export const EliminarPedidoProvedor = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await pedidoProvedorModel.findByIdAndDelete(id)
        // devuelva como una vista
        let pedidoProvedor = await pedidoProvedorModel.find()
        respuesta.status(200).render('index',{pedidoProvedor})
    } catch(error){
        console.log(error)
    }
}

