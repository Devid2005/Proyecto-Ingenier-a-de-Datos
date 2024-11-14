const mongoose = require('mongoose');

const productoSchema = new mongoose.Schema({
    HarmonizedCode:{
        type: String,
        require:true
    },
    NombreProducto:{
        type: String,
        require: true
    },
    PrecioProducto:{
        type: Number,
        require: true
    }
});

module.exports = mongoose.model('producto',productoSchema);
