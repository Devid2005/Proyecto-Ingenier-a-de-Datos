import { userModel } from '../model/userModel.js';
import fs from 'fs';
import csv from 'csv-parser';
// controllers/dataController.js

export const uploadCsv = async (req, res) => {
    try {
        const filePath = req.file.path;
        const data = [];

        // Leer el archivo CSV
        fs.createReadStream(filePath)
            .pipe(csv())
            .on('data', (row) => {
                // Agregar cada fila a la lista de datos
                data.push(row);
            })
            .on('end', async () => {
                try {
                    // Insertar en MongoDB usando el modelo
                    const result = await userModel.insertMany(data);
                    console.log(`${result.length} documentos insertados`);
                    res.send('Datos insertados correctamente');
                } catch (error) {
                    console.error('Error al insertar datos:', error);
                    res.status(500).send('Error al insertar datos');
                }
            });
    } catch (error) {
        console.error('Error al procesar el archivo:', error);
        res.status(500).send('Error al procesar el archivo CSV');
    }
};


export const obtenerDatos = async(peticion,respuesta) =>{
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
        await userModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        let usuarios = await userModel.find()
        respuesta.status(200).json({ usuarios:usuarios})
    } catch(error){
        console.log(error)
    }
}

export const EliminarUsuario = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        // eliminar datos
        await userModel.findByIdAndDelete(id)
        // devuelva como una vista
        let usuarios = await userModel.find()
        respuesta.status(200).json({ usuarios : usuarios})
    } catch(error){
        console.log(error)
    }
}

