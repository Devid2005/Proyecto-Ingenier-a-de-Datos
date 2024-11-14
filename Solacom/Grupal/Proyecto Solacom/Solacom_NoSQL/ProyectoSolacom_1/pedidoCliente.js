const mongoose = require('mongoose');

const pedidoClienteSchema = new mongoose.Schema({
    IdPedidoC:{
        type: Number,
        require:true
    },
    FechaPedido:{
        type: Date,
        require: true
    },
    IdCliente:{
        type: Number,
        require: true
    },
    IdUsuario:{
        type: Number,
        default: true
    },
    Estado:{
        type: String,
        default: 'Pendiente'
    },
    Producto:{
        type: String,
        require: true
    },
    Cantidad:{
        type: Number,
        require: true
    }
});

module.exports = mongoose.model('pedidoCliente',pedidoClienteSchema);