import mongoose from "mongoose";
import { pedidoClienteModel } from '../model/pedidoClienteModel.js';
import { productoModel } from '../model/productoModel.js';

export const obtenerPedidoCliente = async(peticion,respuesta) =>{
    try{
        let PedidoCliente = await pedidoClienteModel.find()
        respuesta.status(200).json({ PedidoCliente : PedidoCliente})
    } catch(error){
        console.log(error);
    }
}

export const CrearPedidoCliente = async (peticion, respuesta) => {
    try {
        // Desestructurar los datos del cuerpo de la solicitud
        const { FechaPedido, IdCliente, IdUsuario, producto, cantidad } = peticion.body;

        // Imprimir el nombre del producto recibido
        console.log('Nombre del producto recibido:', producto);

        // Verificar si el producto contiene caracteres extraños o espacios
        const productoRecibido = producto.trim();
        console.log('Producto recibido después de trim():', productoRecibido);

        // Buscar el producto por nombre, asegurándonos de que sea un string limpio
        const productoBuscado = await productoModel.findOne({ 
            NombreProducto: productoRecibido 
        });

        // Imprimir la consulta realizada para ver qué se está buscando
        console.log('Producto Buscado:', productoBuscado);

        // Verificar que el producto exista
        if (!productoBuscado) {
            return respuesta.status(404).json({ error: "Producto no encontrado" });
        }

        // Validar que la cantidad sea mayor que 0
        if (cantidad <= 0) {
            return respuesta.status(400).json({ error: "La cantidad debe ser mayor a 0" });
        }

        // Comprobar si hay suficiente stock
        if (productoBuscado.cantidad < cantidad) {
            return respuesta.status(400).json({ error: "Stock insuficiente" });
        }

        // Crear el pedido con el nombre del producto
        const nuevoPedido = await pedidoClienteModel.create({
            FechaPedido: FechaPedido,
            IdCliente,
            IdUsuario,
            producto: productoBuscado.NombreProducto, // Guardar el nombre del producto
            cantidad,
        });

        // Actualizar el stock del producto
        productoBuscado.cantidad -= cantidad;
        await productoBuscado.save();

        // Responder con la información del pedido y el stock actualizado
        respuesta.status(201).json({
            message: "Pedido procesado con éxito",
            pedido: nuevoPedido,
            stockActualizado: productoBuscado.cantidad,
        });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ error: "Error interno del servidor" });
    }
};


export const EditarPedidoCliente = async(peticion,respuesta) =>{
    try{
        let id = peticion.params.id
        let data = peticion.body
        // actualizar datos
        const PedidoClienteEditado = await pedidoClienteModel.findByIdAndUpdate(id,data)
        // devuelva como una vista
        respuesta.status(200).json({ mensaje : 'Pedido de Cliente actualizado correctamente', PedidoCliente:PedidoClienteEditado})
    } catch(error){
        console.log(error)
    }
}

export const EliminarPedidoCliente = async(peticion,respuesta) =>{
    try {
        const { id } = peticion.params; // ID del pedido que se quiere eliminar

        // Verificar que el ID sea válido
        if (!mongoose.Types.ObjectId.isValid(id)) {
            return respuesta.status(400).json({ error: "ID de pedido inválido." });
        }

        // Buscar el pedido por su ID
        const pedido = await pedidoClienteModel.findById(id);
        if (!pedido) {
            return respuesta.status(404).json({ error: "Pedido no encontrado." });
        }

        // Obtener los datos del producto asociado al pedido
        const producto = await productoModel.findOne({ NombreProducto: pedido.producto });
        if (!producto) {
            return respuesta.status(404).json({ error: "Producto asociado al pedido no encontrado." });
        }

        // Actualizar el stock del producto
        producto.cantidad += pedido.cantidad;
        await producto.save();

        // Eliminar el pedido
        await pedidoClienteModel.findByIdAndDelete(id);

        // Responder con éxito
        respuesta.status(200).json({
            message: "Pedido eliminado con éxito.",
            stockActualizado: producto.cantidad,
        });
    } catch (error) {
        console.error("Error al eliminar el pedido:", error);
        respuesta.status(500).json({ error: "Error interno del servidor." });
    }
}

