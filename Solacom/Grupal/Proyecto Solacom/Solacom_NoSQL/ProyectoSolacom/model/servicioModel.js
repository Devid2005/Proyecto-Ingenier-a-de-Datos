import mongoose, { Schema } from "mongoose";

const servicioSchema = new Schema({
    NombreServicio: String,
    DescripcionServicio: String
})

export const servicioModel = new mongoose.model('servicios', servicioSchema)