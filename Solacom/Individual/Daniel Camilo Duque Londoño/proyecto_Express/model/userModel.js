import mongoose, { Schema } from "mongoose";

const userSchema = new Schema({
    name: String,
    lastname: String,
    email: String,
    role: String
})

export const userModel = new mongoose.model('Users', userSchema)