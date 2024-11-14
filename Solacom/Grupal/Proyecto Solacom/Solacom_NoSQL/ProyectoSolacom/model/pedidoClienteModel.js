import mongoose, { Schema } from "mongoose";

const pedidoClienteSchema = new Schema({
    IdPedidoC: Number,
    FechaPedido: Date,
    IdCliente: Number,
    IdUsuario: Number,
    Estado: { type: String, default: 'Pendiente' } ,// Estado del pedido: Pendiente, Entregado, Cancelado
    producto: String,
    cantidad: Number
})

export const pedidoClienteModel = new mongoose.model('pedido de Clientes', pedidoClienteSchema)