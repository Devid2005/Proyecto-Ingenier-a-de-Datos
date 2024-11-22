import mongoose, { Schema } from "mongoose";

const ClientsSchema = new Schema({
    name: String,
    lastname: String,
    email: String
})

export const clienteModel = new mongoose.model('Clients', ClientsSchema)