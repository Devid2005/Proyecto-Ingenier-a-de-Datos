import { Router } from 'express'
import { CrearpedidoProvedor, obtenerPedidoProvedor, EditarPedidoProvedor, EliminarPedidoProvedor} from "../controller/PedidoProvedorController.js";
const router = Router()

router.get('/Pedido-a-Provedores', obtenerPedidoProvedor)
router.post('/Pedido-a-Provedores', CrearpedidoProvedor)
router.put('/Pedido-a-Provedores', EditarPedidoProvedor)
router.delete('/Pedido-a-Provedores', EliminarPedidoProvedor)

export default router;