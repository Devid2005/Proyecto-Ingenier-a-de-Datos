import mongoose, { Schema } from "mongoose";

const userSchema = new Schema({
    name: { type: String, required: true },
    age: { type: Number, required: true },
    email: { type: String, required: true, unique: true },
    active: { type: Boolean, default: false }
})

export const userModel = new mongoose.model('Users', userSchema)