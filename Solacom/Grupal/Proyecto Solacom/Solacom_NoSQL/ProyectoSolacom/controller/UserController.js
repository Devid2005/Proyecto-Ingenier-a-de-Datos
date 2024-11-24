import { userModel } from '../model/userModel.js';
import fs from 'fs';
import csv from 'csv-parser';

// controllers/dataController.js

export const uploadCSV = async (req, res) => {
    try {
        const results = [];
        const filePath = 'C:/Users/Asus/Documents/MACC/Ingeneria de datos/Datos_Solacom/Datos_Solacom_Usuario.csv'; // Ruta del archivo CSV en el sistema de archivos

        // Verificar si el archivo existe
        if (!fs.existsSync(filePath)) {
            return res.status(404).json({ message: 'Archivo no encontrado' });
        }

        // Leer y procesar el archivo CSV
        fs.createReadStream(filePath)
    .pipe(csv())
    .on('data', (data) => results.push(data))
    .on('end', async () => {
        console.log(results); // Para verificar que los datos se están cargando correctamente
        if (results.length === 0) {
            return res.status(400).json({ message: 'No se encontraron datos en el archivo CSV' });
        }
        await userModel.insertMany(results);
        res.status(200).json({ message: 'Datos cargados exitosamente desde el archivo' });
    });
    }catch (error) {
        res.status(500).json({ message: 'Error al cargar el archivo CSV', error });
    }
};


export const obtenerUsuarios = async(peticion,respuesta) =>{
    try{
        let usuarios = await userModel.find()
        respuesta.status(200).json({ usuarios : usuarios})
    } catch(error){
        console.log(error);
    }
}

export const CrearUsuarios = async(peticion,respuesta) =>{
    try{
        let data = peticion.body
        // guardar datos
        await userModel.create(data)
        // devuelva como una vista 
        let usuarios = await userModel.find()
        respuesta.status(200).json({ userModel: usuarios})
    } catch(error){
        console.log(error)
    }
}

export const EditarUsuario = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        const UsuarioEditado = await userModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'usuario actualizado correctamente', usuario:UsuarioEditado})
    } catch(error){
        console.log(error)
    }
}
export const EliminarUsuario = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        const UsuarioEliminado = await userModel.findByIdAndDelete(id);
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'usuario eliminado correctamente', usuario:UsuarioEliminado})
    } catch(error){
        console.log(error)
    }
}



