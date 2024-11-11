import { usuariosModel } from '../model/usuariosModel.js';

export const obtenerDatos = async(peticion,respuesta) =>{
    try{
        let usuarios = await usuariosModel.find()
        respuesta.status(200).render('index',{usuarios})
    } catch(error){
        console.log(error);
    }
}

export const CrearUsuarios = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await usuariosModel.create(data)
        // devuelva como una vista 
        let usuarios = await usuariosModel.find()
        respuesta.status(200).render('index',{usuarios})
    } catch(error){
        console.log(error)
    }
}

export const EditarUsuario = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        await usuariosModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let usuarios = await usuariosModel.find()
        respuesta.status(200).render('index',{usuarios})
    } catch(error){
        console.log(error)
    }
}

export const EliminarUsuario = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await usuariosModel.findByIdAndDelete(id)
        // devuelva como una vista
        let usuarios = await usuariosModel.find()
        respuesta.status(200).render('index',{usuarios})
    } catch(error){
        console.log(error)
    }
}

export const EncontarPorNombre = async (peticion, respuesta) => {
    try {
        let nombre = peticion.params.nombre;
        await usuariosModel.find({ NombreUsuario: `"${nombre}"` }); 
        if (!nombre) {
            console.log('Usuario ' + nombre + ' no encontrado');
            respuesta.status(404).send(`Usuario ${nombre} no encontrado`);
        } else {
            let usuario = await usuariosModel.find({ NombreUsuario: nombre });
            respuesta.status(200).render('index', { usuario });
        }
    } catch (error) {
        console.error('Error al buscar el usuario:', error);
        respuesta.status(500).send('Error al buscar el usuario');
    }
}

export const buscarUsuariosPorEdad = async(peticion,respuesta) => {
    try{
        let edadminima = peticion.query.edadminima
        if(edadminima > 30){    
            let usuarios = await usuariosModel.find()
            respuesta.status(200).render('index',{usuarios})
        }else{
            respuesta.status(400).send('No hay usuarios mayores de 30')
        }
    }catch(error){
        console.error('Error al buscar el usuario: ',error);
        respuesta.status(400).send('Error al buscar el usuario');
    }
}