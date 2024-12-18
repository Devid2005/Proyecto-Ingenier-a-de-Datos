import { servicioModel } from '../model/servicioModel.js';

export const obtenerServicios = async(peticion,respuesta) =>{
    try{
        let servicio = await servicioModel.find()
        respuesta.status(200).json({ servicioModel: servicio})
    } catch(error){
        console.log(error);
    }
}

export const CrearServicio = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await servicioModel.create(data)
        // devuelva como una vista 
        let servicios = await servicioModel.find()
        respuesta.status(200).json({ servicioModel: servicios})
    } catch(error){
        console.log(error)
    }
}

export const EditarServicio = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await servicioModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let servicio = await servicioModel.find()
        respuesta.status(200).json({ servicioModel: servicio})
    } catch(error){
        console.log(error)
    }
}

// eliminar servicio

export const EliminarServicio = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        const ServicioEliminado = await servicioModel.findByIdAndDelete(id);
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'Servicio eliminado correctamente', Servicio:ServicioEliminado})
    } catch(error){
        console.log(error)
    }
}

