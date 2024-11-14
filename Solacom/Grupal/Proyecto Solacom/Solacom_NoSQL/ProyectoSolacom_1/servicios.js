const mongoose = require('mongoose');

const servicioSchema = new mongoose.Schema({
    IdServicio:{
        type: String,
        require:true
    },
    IdPedidoC:{
        type: Number,
        require: true
    },
    DescripcionServicio:{
        type: String,
        require: true
    },
    activo:{
        type: Boolean,
        default: true
    }
});

module.exports = mongoose.model('servicio',servicioSchema);