import mongoose, { Schema } from "mongoose";

const pedidoProvedorSchema = new Schema({
    IdPedidoP: Number,
    FechaPedido: Date,
    IdProvedor: Number,
    IdUsuario: Number,
    Estado: { type: String, default: 'Pendiente' } ,// Estado del pedido: Pendiente, Entregado, Cancelado
    producto: String,
    precio_unidad: Number,
    cantidad: Number
})

export const pedidoProvedorModel = new mongoose.model('pedido a Provedor', pedidoProvedorSchema)