import mongoose, { Schema } from "mongoose";

const servicioSchema = new Schema({
    IdServicio: String,
    IdPedidoC: Number,
    NombreServicio: String,
    DescripcionServicio: String
})

export const servicioModel = new mongoose.model('servicios', servicioSchema)