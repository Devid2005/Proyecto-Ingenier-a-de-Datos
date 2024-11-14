import mongoose, { Schema } from "mongoose";

const clienteSchema = new Schema({
    IdCliente: String,
    NombreCliente: String,
    Direccion: String,
    email: String,
    estadoCliente: { type: Boolean, default: true }
})

export const clienteModel = new mongoose.model('clientes', clienteSchema)