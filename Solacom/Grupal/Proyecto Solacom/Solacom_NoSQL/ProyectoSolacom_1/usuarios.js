const mongoose = require('mongoose');

const usuarioSchema = new mongoose.Schema({
    IdUsuario:{
        type: Number,
        require:true
    },
    Nombreusuariol:{
        type: String,
        require: true
    },
    Emailusuario:{
        type: String,
        require: true
    },
    RolUsuario:{
        type: Boolean,
        default: true
    }
});

module.exports = mongoose.model('usuario',usuarioSchema);

