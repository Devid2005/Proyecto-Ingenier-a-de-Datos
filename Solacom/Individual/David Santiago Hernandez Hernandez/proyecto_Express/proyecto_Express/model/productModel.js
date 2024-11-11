import mongoose, { Schema } from "mongoose";

const productSchema = new mongoose.Schema({
    nombre: { type: String, required: true },
    precio: { type: Number, required: true },
    categoria: { type: String, required: true },
    en_stock: { type: Boolean, default: true }
})
  
export const productModel = new mongoose.model('Products', productSchema)