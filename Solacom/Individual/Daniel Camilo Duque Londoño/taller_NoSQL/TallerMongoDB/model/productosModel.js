import mongoose, { Schema } from "mongoose";

const productosSchema = new Schema({
    NombreProducto: String,
    precio: Number,
    categoria: String
})

export const productosModel = new mongoose.model('Productos', productosSchema)