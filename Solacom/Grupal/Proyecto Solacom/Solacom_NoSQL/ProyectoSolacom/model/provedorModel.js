import mongoose, { Schema } from "mongoose";

const provedorSchema = new Schema({
    IdProvedor: String,
    NombreProvedor: String
})

export const provedorModel = new mongoose.model('provedores', provedorSchema)