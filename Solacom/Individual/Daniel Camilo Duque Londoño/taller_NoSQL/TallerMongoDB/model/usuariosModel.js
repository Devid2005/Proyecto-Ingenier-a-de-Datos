import mongoose, { Schema } from "mongoose";

const userSchema = new Schema({
    NombreUsuario: String,
    Edad: Number,
    EmailUsuario: String
})

export const usuariosModel = new mongoose.model('Usuarios', userSchema)