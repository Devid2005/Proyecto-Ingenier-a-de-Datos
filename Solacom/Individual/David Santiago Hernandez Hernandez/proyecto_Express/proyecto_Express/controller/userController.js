import { userModel } from "../model/userModel.js";

export const obtenerDatos = async (req, res) => {
    try {
        const usuarios = await userModel.find();
        res.status(200).json(usuarios);
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
}
export const crearUsuario = async (req, res) => {
  try {
    const usuarios = req.body; 
    if (!Array.isArray(usuarios)) {
      return res.status(400).json({ error: 'El cuerpo de la solicitud debe ser un array de usuarios' });
    }
    const result = await userModel.insertMany(usuarios);
    res.status(201).json({ message: 'Usuarios agregados exitosamente', usuarios: result });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}


export const encontrarUsuarioPorNombre = async (req, res) => {
    try {
        const usuario = await userModel.findOne({ name: req.params.name });
        if (usuario) {
          res.status(200).json(usuario);
        } else {
          res.status(404).json({ message: "Usuario no encontrado" });
        }
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
}

export const encontrarUsuarioMayores = async (req, res) => {
    try {
      const { edadMinima } = req.body; // Captura el parámetro 'edadMinima' del cuerpo de la solicitud
      
      if (!edadMinima) {
        return res.status(400).json({ message: 'Se requiere el parámetro edadMinima' });
      }
      
      const usuarios = await userModel.find({ age: { $gte: edadMinima } });
      
      if (usuarios.length === 0) {
        return res.status(404).json({ message: 'No se encontraron usuarios mayores o iguales a la edad especificada' });
      }
      
      res.status(200).json(usuarios);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
}


export const actualizarEdadUsuario = async (req, res) => {
    try {
        const { nombre, edad } = req.body;
        const usuario = await userModel.updateOne(
          { name: nombre },
          { $set: { age: edad } }
        );
        if (!usuario) return res.status(404).json({ error: 'Usuario no encontrado' });
        res.status(200).json(usuario);
      } catch (error) {
        res.status(400).json({ error: error.message });
      }    
}

export const activarUsuariosMayores = async (req, res) => {
    try {
        const { edadMinima } = req.body;
        await userModel.updateMany(
          { age: { $gte: edadMinima } },
          { $set: { active: true } }
        );
        res.status(200).json({ message: 'Usuarios mayores de edad mínima activados' });
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
}

export const eliminarUsuarioPorNombre = async (req, res) => {
    try {
        const { nombre } = req.body;
        const usuario = await userModel.deleteOne({ name: nombre });
        if (!usuario) return res.status(404).json({ error: 'Usuario no encontrado' });
        res.status(200).json({ message: 'Usuario eliminado' });
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
}

export const eliminarUsuariosMenores = async (req, res) => {
  try {
    const { edadMaxima } = req.body;
    
    
    await userModel.deleteMany({ age: { $lt: edadMaxima } });
    
    
    res.status(200).json({ message: 'Usuarios Eliminados' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}
