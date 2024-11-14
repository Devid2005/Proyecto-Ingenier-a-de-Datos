import mongoose, { Schema } from "mongoose";

const userSchema = new Schema({
    IdUsuario: Number,
    NombreUsuario: String,
    EmailUsuario: String,
    rolUsuario: String
})

export const userModel = new mongoose.model('Users', userSchema)