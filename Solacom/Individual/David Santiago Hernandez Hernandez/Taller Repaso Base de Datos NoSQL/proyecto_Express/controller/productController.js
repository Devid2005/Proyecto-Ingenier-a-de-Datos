import { productModel } from "../model/productModel.js";

export const obtenerProductos = async (req, res) => {
    try {
      const productos = await productModel.find();
      res.status(200).json(productos);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
}

export const crearProducto = async (req, res) => {
  try {
    const producto = new productModel(req.body);
    await producto.save();
    res.status(201).json(producto);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
}

export const encontrarProductosPorPrecio  = async (req, res) => {
    try {
        const { precioMinimo } = req.body; 
        const productos = await productModel.find({ precio: { $gt: precioMinimo } });
        res.status(200).json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

export const ordenarProductosPorPrecio = async (req, res) => {
    try {
        const productos = await productModel.find().sort({ precio: -1 });
        res.status(200).json(productos);
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
}

export const actualizarEnStockFalseParaCaros = async (req, res) => {
    try {
        const { precioMinimo } = req.body;
        const result = await productModel.updateMany(
          { precio: { $gt: precioMinimo } },
          { $set: { en_stock: false } }
        );
        res.status(200).json({ message: `Estado de en_stock actualizado para productos con precio mayor a ${precioMinimo}`, modificados: result.nModified });
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
}

export const eliminarProducto = async (req, res) => {
    try {
      const { nombre } = req.body;
      const producto = await productModel.deleteOne({ nombre: nombre });
      if (!producto) return res.status(404).json({ error: 'Producto no encontrado' });
      res.status(200).json({ message: 'Producto eliminado' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
}

export const eliminarProductosPorPrecio = async (req, res) => {
    try {
        const { precioMaximo } = req.body;
        const result = await productModel.deleteMany({ precio: { $lt: precioMaximo } });
        res.status(200).json({ message: `Productos con precio menor a ${precioMaximo} eliminados`, eliminados: result.deletedCount });
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
}




