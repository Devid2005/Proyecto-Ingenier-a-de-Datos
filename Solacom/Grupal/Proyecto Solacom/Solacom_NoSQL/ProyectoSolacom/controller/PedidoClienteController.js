import { pedidoClienteModel } from '../model/pedidoClienteModel.js';

export const obtenerPedidoCliente = async(peticion,respuesta) =>{
    try{
        let pedidoCliente = await pedidoClienteModel.find()
        respuesta.status(200).render('index',{pedidoCliente})
    } catch(error){
        console.log(error);
    }
}

export const CrearpedidoCliente = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await pedidoClienteModel.create(data)
        // devuelva como una vista 
        let pedidoCliente = await pedidoClienteModel.find()
        respuesta.status(200).render('index',{pedidoCliente})
    } catch(error){
        console.log(error)
    }
}

export const EditarPedidoCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await pedidoClienteModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let pedidoCliente = await pedidoClienteModel.find()
        respuesta.status(200).render('index',{pedidoCliente})
    } catch(error){
        console.log(error)
    }
}

export const EliminarPedidoCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await pedidoClienteModel.findByIdAndDelete(id)
        // devuelva como una vista
        let pedidoCliente = await pedidoClienteModel.find()
        respuesta.status(200).render('index',{pedidoCliente})
    } catch(error){
        console.log(error)
    }
}

// ver cproducytos de una compra con su precio

export const ObtenerProductosPedidoCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let pedidoCliente = await pedidoClienteModel.findById(id)
        if(!pedidoCliente) return respuesta.status(404).send('Pedido de cliente no encontrado')
        let productos = await pedidoCliente.productos
        respuesta.status(200).json(productos)
    } catch(error){
        console.log(error)
        respuesta.status(500).send('Error interno')
    }
}

