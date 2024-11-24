import { clienteModel } from "../model/clienteModel.js";
import { pedidoClienteModel } from "../model/pedidoClienteModel.js";
import { productoModel } from "../model/productoModel.js";
import { provedorModel } from "../model/provedorModel.js";
import { pedidoProvedorModel } from "../model/pedidoProvedorModel.js";

// Función para generar una factura de cliente

export const GenerarFacturaCliente = async (req, res) => {
    try {
        const { IdCliente } = req.params;
        // Buscar el pedido por su ID
        const pedido = await pedidoClienteModel.findOne({ _id: IdCliente })
        if (!pedido) {
            return res.status(404).json({ error: "Pedido no encontrado" });
        }
        // Buscar datos del cliente
        const cliente = await clienteModel.findOne({ IdCliente: pedido.IdCliente });
        if (!cliente) {
            return res.status(404).json({ error: "Cliente no encontrado" });
        }
        // Buscar información del producto
        const producto = await productoModel.findOne({ NombreProducto: pedido.producto });
        if (!producto) {
            return res.status(404).json({ error: "Producto no encontrado" });
        }
        // Calcular subtotal y total
        const subtotal = producto.PrecioProducto * pedido.cantidad;
        const total = subtotal; 
        // Crear la estructura de la factura
        const factura = {
            Cliente: {
                IdCliente: cliente.IdCliente,
                Nombre: cliente.NombreCliente,
                Direccion: cliente.Direccion,
                Email: cliente.email,
            },
            Pedido: {
                IdCliente,
                FechaPedido: pedido.FechaPedido,
                Estado: pedido.Estado,
                Producto: pedido.producto,
                Cantidad: pedido.cantidad,
            },
            DetallesProducto: {
                HarmonizedCode: producto.HarmonizedCode,
                NombreProducto: producto.NombreProducto,
                PrecioUnitario: producto.PrecioProducto,
                Subtotal: subtotal,
            },
            Total: total,
        };
        // Enviar la factura como respuesta
        res.status(200).json({ factura });
    } catch (error) {
        console.error("Error al generar la factura:", error);
        res.status(500).json({ error: "Error interno del servidor" });
    }
};

// funcion para generar una factura de provedor

export const GenerarFacturaProvedor = async (req, res) => {
    try {
        const { IdPedidoProvedor } = req.params;
        // Buscar el pedido por su ID
        const pedido = await pedidoProvedorModel.findOne({ _id: IdPedidoProvedor })
        if (!pedido) {
            return res.status(404).json({ error: "Pedido no encontrado" });
        }
        // Buscar datos del proveedor
        const proveedor = await provedorModel.findOne({ IdPedidoP: pedido.IdPedidoProvedor });
        if (!proveedor) {
            return res.status(404).json({ error: "Proveedor no encontrado" });
        }
        // Buscar información del producto
        const producto = await productoModel.findOne({ NombreProducto: pedido.producto });
        if (!producto) {
            return res.status(404).json({ error: "Producto no encontrado" });
        }
        // Calcular subtotal y total
        const subtotal = producto.PrecioProducto * pedido.cantidad;
        const total = subtotal;
        // Crear la estructura de la factura
        const factura = {
            Provedor: {
                NombreProvedor: proveedor.NombreProvedor
            },
            Pedido: {
                IdPedidoProvedor,
                FechaPedido: pedido.FechaPedido,
                Estado: pedido.Estado,
                Producto: pedido.Producto,
                Cantidad: pedido.Cantidad,
            },
            DetallesProducto: {
                HarmonizedCode: producto.HarmonizedCode,
                NombreProducto: producto.NombreProducto,
                PrecioUnitario: producto.PrecioProducto,
                Subtotal: subtotal,
            },
            Total: total,
        };
        // Enviar la factura como respuesta
        res.status(200).json({ factura });
    } catch (error) {
        console.error("Error al generar la factura:", error);
        res.status(500).json({ error: "Error interno del servidor" });
    }
}