import { Router } from 'express'
import { CrearPedidoCliente, obtenerPedidoCliente, EditarPedidoCliente, EliminarPedidoCliente} from "../controller/PedidoClienteController.js";
const router = Router()

router.get('/Pedido-de-Clientes', obtenerPedidoCliente)
router.post('/Pedido-de-Clientes', CrearPedidoCliente)
router.put('/Pedido-de-Clientes/:id', EditarPedidoCliente)
router.delete('/Pedido-de-Clientes/:id', EliminarPedidoCliente)

export default router;