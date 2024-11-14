import { Router } from 'express'
import { CrearpedidoCliente, obtenerPedidoCliente, EditarPedidoCliente, EliminarPedidoCliente} from "../controller/PedidoClienteController.js";
const router = Router()

router.get('/Pedido-de-Clientes', obtenerPedidoCliente)
router.post('/Pedido-de-Clientes', CrearpedidoCliente)
router.put('/Pedido-de-Clientes', EditarPedidoCliente)
router.delete('/Pedido-de-Clientes', EliminarPedidoCliente)

export default router;