import { Router } from 'express'
import { CrearPedidoProvedor, obtenerPedidoProvedor, EditarPedidoProvedor, EliminarPedidoProvedor} from "../controller/PedidoProvedorController.js";
const router = Router()

router.get('/Pedido-a-Provedores', obtenerPedidoProvedor)
router.post('/Pedido-a-Provedores', CrearPedidoProvedor)
router.put('/Pedido-a-Provedores/:id', EditarPedidoProvedor)
router.delete('/Pedido-a-Provedores/:id', EliminarPedidoProvedor)

export default router;