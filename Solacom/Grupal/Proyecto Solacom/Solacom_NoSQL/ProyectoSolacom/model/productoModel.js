import mongoose, { Schema } from "mongoose";

const productoSchema = new Schema({
    HarmonizedCode: String,
    NombreProducto: String,
    PrecioProducto: Number
})

export const productoModel = new mongoose.model('productos', productoSchema)