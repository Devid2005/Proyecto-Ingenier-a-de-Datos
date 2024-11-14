const mongoose = require('mongoose');

const pedidoSchema = new mongoose.Schema({
    IdPedidoP:{
        type: Number,
        require:true
    },
    FechaPedido:{
        type: Date,
        require: true
    },
    IdProvedor:{
        type: Number,
        require: true
    },
    IdUsuario:{
        type: Number,
        require: true
    },
    Estado:{
        type: String,
        default: 'Pendiente'
    },
    producto:{
        type: String,
        require: true
    },
    precio_unidad:{
        type: Number,
        require: true
    },
    cantidad:{
        type: Number,
        require: true
    }
});

module.exports = mongoose.model('pedido',pedidoSchema);