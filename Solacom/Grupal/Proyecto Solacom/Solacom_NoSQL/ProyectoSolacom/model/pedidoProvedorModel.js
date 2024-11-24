import mongoose, { Schema } from "mongoose";

const pedidoProvedorSchema = new Schema({
    IdPedidoP: Number,
    FechaPedido: String,
    IdProvedor: String,
    IdUsuario: Number,
    Estado: { type: String, default: 'Pendiente' } ,// Estado del pedido: Pendiente, Entregado, Cancelado
    producto: String,
    cantidad: Number
})

export const pedidoProvedorModel = new mongoose.model('pedido a Provedor', pedidoProvedorSchema)