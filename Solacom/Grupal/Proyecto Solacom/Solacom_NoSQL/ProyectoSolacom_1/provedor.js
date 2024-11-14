const mongoose = require('mongoose');

const provedorSchema = new mongoose.Schema({
    NombreProvedor:{
        type: String,
        require:true
    },
    IdProvedor:{
        type: Number,
        require: true
    }
});

module.exports = mongoose.model('provedor',provedorSchema);
