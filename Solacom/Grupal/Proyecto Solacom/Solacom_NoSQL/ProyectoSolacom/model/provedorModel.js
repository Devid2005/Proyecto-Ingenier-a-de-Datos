import mongoose, { Schema } from "mongoose";

const provedorSchema = new Schema({
    NombreProvedor: String
})

export const provedorModel = new mongoose.model('provedores', provedorSchema)