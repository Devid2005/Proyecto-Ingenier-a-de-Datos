import { provedorModel } from '../model/provedorModel.js';

export const obtenerProvedor = async(peticion,respuesta) =>{
    try{
        let Provedor = await provedorModel.find()
        respuesta.status(200).json({ Provedor : Provedor})
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
        let Provedor = await provedorModel.find()
        respuesta.status(200).json({ provedorModel: Provedor})
    } catch(error){
        console.log(error)
    }
}

export const EditarProvedor = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        const ProvedorEditado = await provedorModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'Provedor actualizado correctamente', Provedor:ProvedorEditado})
    } catch(error){
        console.log(error)
    }
}
export const EliminarProvedor = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        const ProvedorEliminado = await provedorModel.findByIdAndDelete(id);
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'Provedor eliminado correctamente', Provedor:ProvedorEliminado})
    } catch(error){
        console.log(error)
    }
}

