const mongoose = require('mongoose');

const ClienteSchema = new mongoose.Schema({
    nombre:{
        type: String,
        require:true
    },
    edad:{
        type: Number,
        require: true
    },
    email:{
        type: String,
        require: true
    },
    activo:{
        type: Boolean,
        default: true
    }
});

module.exports = mongoose.model('Cliente',ClienteSchema);