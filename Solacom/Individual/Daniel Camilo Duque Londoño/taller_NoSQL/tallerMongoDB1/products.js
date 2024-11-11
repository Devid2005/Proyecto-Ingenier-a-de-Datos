const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    nombre:{
        type: String,
        require:true
    },
    precio:{
        type: Number,
        require: true
    },
    categoria:{
        type: String,
        require: true
    }
});

module.exports = mongoose.model('productos',productSchema);