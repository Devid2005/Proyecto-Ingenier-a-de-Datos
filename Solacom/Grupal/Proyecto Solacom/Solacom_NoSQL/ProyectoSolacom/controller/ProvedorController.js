import { provedorModel } from '../model/provedorModel.js';

export const obtenerProvedores = async(peticion,respuesta) =>{
    try{
        let provedor = await provedorModel.find()
        respuesta.status(200).render('index',{provedor})
    } catch(error){
        console.log(error);
    }
}

export const CrearProvedor = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await provedorModel.create(data)
        // devuelva como una vista 
        let provedor = await provedorModel.find()
        respuesta.status(200).render('index',{provedor})
    } catch(error){
        console.log(error)
    }
}

export const EditarProvedor = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await provedorModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let provedor = await provedorModel.find()
        respuesta.status(200).render('index',{provedor})
    } catch(error){
        console.log(error)
    }
}

export const EliminarProvedor = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await provedorModel.findByIdAndDelete(id)
        // devuelva como una vista
        let provedor = await provedorModel.find()
        respuesta.status(200).render('index',{provedor})
    } catch(error){
        console.log(error)
    }
}

