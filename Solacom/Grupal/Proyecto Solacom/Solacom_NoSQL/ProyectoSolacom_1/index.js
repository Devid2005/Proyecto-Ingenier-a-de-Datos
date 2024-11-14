// conexion a BD
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// crear el cuerpo de las peticiones a hacer (Middleware)

app.use(express.json());

// conexión BD

mongoose.connect("mongodb://localhost:27017/Solacom1",{
    useNewURLParser : true,
    useUnifiedTopology: true
}).then(() => console.log('Se conectó a Mongo')) 
.catch(err=> console.error('No se conectó a BD',err));

// Iniciar el servidor

app.listen(PORT,()=>{console.log('servidor ejecutandose sobre el puerto:,${PORT}')});

// agregar rutas para manipular usuarios

const User = require('./usuarios');

// agregar usuarios

app.post('/usuarios', async (req,res) => {
    try {
        const user = new user(req.body);
        await user.save();
        res.status(201).json(user);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

// obtener todos los usuarios

app.get('/usuarios', async (req, res) => {
    try {
        const users = await users.find();
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// eliminar usuario

app.delete('/usuarios/:id', async (req, res) => {
    try {
        const user = await user.findByIdAndDelete(req.params.id);
        if (user) res.json(user);
        else res.status(404).json({ message: 'Usuario no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// actualizar usuario

app.patch('/usuarios/:id', async (req, res) => {
    try {
        const user = await user.findByIdAndUpdate(req.params.id, req.body, { new: true });
        if (user) res.json(user);
        else res.status(404).json({ message: 'Usuario no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// obtener usuarios que son administradores

app.get('/usuarios/admin', async (req, res) => {
    try {
        const users = await users.find({isAdmin: true });
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// obtener usuarios que son clientes

app.get('/usuarios/clientes', async (req, res) => {
    try {
        const users = await users.find({isAdmin: false });
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});
// agregar rutas para manipular servicios

const servicios = require('./servicios');

// agregar servicios

app.post('/servicios', async (req, res) => {
    try {
        const servicio = new servicio(req.body);
        await servicio.save();
        res.status(201).json(servicio);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

// obtener todos los servicios

app.get('/servicios', async (req, res) => {
    try {
        const servicios = await servicios.find();
        res.json(servicios);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// eliminar servicio

app.delete('/servicios/:id', async (req, res) => {
    try {
        const servicio = await servicio.findByIdAndDelete(req.params.id);
        if (servicio) res.json(servicio);
        else res.status(404).json({ message: 'Servicio no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// actualizar servicio

app.patch('/servicios/:id', async (req, res) => {
    try {
        const servicio = await servicio.findByIdAndUpdate(req.params.id, req.body, { new: false });
        if (servicio) res.json(servicio);
        else res.status(404).json({ message: 'Servicio no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});
// agregar rutas para manipular provedores

const provedores = require('./provedor');

// agregar provedores

app.post('/provedor', async (req, res) => {
    try {
        const proveedor = new proveedor(req.body);
        await proveedor.save();
        res.status(201).json(proveedor);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

// obtener todos los provedores

app.get('/provedor', async (req, res) => {
    try {
        const provedores = await provedores.find();
        res.json(provedores);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// eliminar proveedor

app.delete('/provedor/:id', async (req, res) => {
    try {
        const proveedor = await proveedor.findByIdAndDelete(req.params.id);
        if (proveedor) res.json(proveedor);
        else res.status(404).json({ message: 'Proveedor no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// actualizar proveedor

app.patch('/provedor/:id', async (req, res) => {
    try {
        const proveedor = await proveedor.findByIdAndUpdate(req.params.id, req.body, { new: false });
        if (proveedor) res.json(proveedor);
        else res.status(404).json({ message: 'Proveedor no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// agregar rutas para manipular productos

const productos = require('./producto');

// agregar productos

app.post('/producto', async (req, res) => {
    try {
        const producto = new producto(req.body);
        await producto.save();
        res.status(201).json(producto);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

// obtener todos los productos

app.get('/producto', async (req, res) => {
    try {
        const productos = await productos.find();
        res.json(productos);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// eliminar producto

app.delete('/producto/:id', async (req, res) => {
    try {
        const producto = await producto.findByIdAndDelete(req.params.id);
        if (producto) res.json(producto);
        else res.status(404).json({ message: 'Producto no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// actualizar el precio de un producto

app.patch('/producto/:id', async (req, res) => {
    const {IdProducto} = req.params
    const {NuevoPrecio} = req.body
    try {
        const producto = await producto.findOneByIdAndUpdate({IdProducto: IdProducto},{PrecioProducto: NuevoPrecio});
        if (!productoActualizado) {
            return res.status(404).json({ mensaje: `Producto con Id ${IdProducto} no encontrado.` });
        } 
        res.json({ mensaje: 'Precio actualizado', producto: productoActualizado });
    }catch (error) {
        console.error('Error al actualizar el precio del producto:', error);
        res.status(500).json({ mensaje: 'Error interno del servidor' });
    }
})

// agregar rutas para manipular pedidos a provedores

const pedidoProvedor = require('./pedidoProvedor');

// agregar pedidos a provedores

app.post('/pedidoProvedore', async (req, res) => {
    try {
        const pedido = new pedido(req.body);
        await pedido.save();
        res.status(201).json(pedido);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

// obtener todos los pedidos a provedores

app.get('/pedidoProvedor', async (req, res) => {
    try {
        const pedidos = await pedidos.find();
        res.json(pedidos);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// eliminar pedido a proveedor

app.delete('/pedidoProvedor/:id', async (req, res) => {
    try {
        const pedido = await pedido.findByIdAndDelete(req.params.id);
        if (pedido) res.json(pedido);
        else res.status(404).json({ message: 'Pedido no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// cambiar estado de pedido a proveedor

app.patch('/pedidoProvedor/:id', async (req, res) => {
    const {IdPedido} = req.params
    const {NuevoEstado} = req.body
    try {
        const pedido = await pedido.findOneByIdAndUpdate({IdPedido: IdPedido},{EstadoPedido: NuevoEstado});
        if (!pedidoActualizado) {
            return res.status(404).json({ mensaje: `Pedido con Id ${IdPedido} no encontrado.` });
        } 
        res.json({ mensaje: 'Estado actualizado', pedido: pedidoActualizado });
    }catch (error) {
        console.error('Error al actualizar el estado del pedido:', error);
        res.status(500).json({ mensaje: 'Error interno del servidor' });
    }
})
// agregar rutas para manipular pedidos de clientes

const pedidoClientes = require('./pedidoCliente');

// agregar pedidos de clientes

app.post('/pedidoCliente', async (req, res) => {
    try {
        const pedido = new pedido(req.body);
        await pedido.save();
        res.status(201).json(pedido);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

// obtener todos los pedidos de clientes

app.get('/pedidoCliente', async (req, res) => {
    try {
        const pedidos = await pedidos.find();
        res.json(pedidos);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// eliminar pedido de cliente

app.delete('/pedidoCliente/:id', async (req, res) => {
    try {
        const pedido = await pedido.findByIdAndDelete(req.params.id);
        if (pedido) res.json(pedido);
        else res.status(404).json({ message: 'Pedido no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// cambiar estado de pedido de cliente

app.patch('/pedidoCliente/:id', async (req, res) => {
    const {IdPedido} = req.params
    const {NuevoEstado} = req.body
    try {
        const pedido = await pedido.findOneByIdAndUpdate({IdPedido: IdPedido},{EstadoPedido: NuevoEstado});
        if (!pedidoActualizado) {
            return res.status(404).json({ mensaje: `Pedido con Id ${IdPedido} no encontrado.` });
        } 
        res.json({ mensaje: 'Estado actualizado', pedido: pedidoActualizado });
    }catch (error) {
        console.error('Error al actualizar el estado del pedido:', error);
        res.status(500).json({ mensaje: 'Error interno del servidor' });
    }
})

// agregar rutas para manipular clientes

const cliente = require('./clientes');

// agregar clientes

app.post('/clientes', async (req, res) => {
    try {
        const cliente = new cliente(req.body);
        await cliente.save();
        res.status(201).json(cliente);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

// obtener todos los clientes

app.get('/clientes', async (req, res) => {
    try {
        const clientes = await cliente.find();
        res.json(clientes);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// eliminar cliente

app.delete('/clientes/:id', async (req, res) => {
    try {
        const cliente = await cliente.findByIdAndDelete(req.params.id);
        if (cliente) res.json(cliente);
        else res.status(404).json({ message: 'Cliente no encontrado' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// actualizar cliente

app.patch('/clientes/:id', async (req, res) => {
    const {id} = req.params
    const {nombre, direccion, telefono} = req.body
    try {
        const cliente = await cliente.findOneAndUpdate({_id: id},{nombre: nombre, direccion: direccion, telefono: telefono});
        if (!clienteActualizado) {
            return res.status(404).json({ mensaje: `Cliente con Id ${id} no encontrado.` });
        } 
        res.json({ mensaje: 'Cliente actualizado', cliente: clienteActualizado });
    }catch (error) {
        console.error('Error al actualizar los datos del cliente:', error);
        res.status(500).json({ mensaje: 'Error interno del servidor' });
    }
})

