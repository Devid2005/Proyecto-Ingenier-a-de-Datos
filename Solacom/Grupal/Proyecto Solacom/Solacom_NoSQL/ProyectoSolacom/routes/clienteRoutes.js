import { Router } from 'express'
import { CrearCliente, obtenerCliente, EditarCliente, EliminarCliente} from "../controller/clienteController.js";
const router = Router()

router.get('/Clientes', obtenerCliente)
router.post('/Clientes', CrearCliente)
router.put('/Clientes/:id', EditarCliente)
router.delete('/Clientes/:id', EliminarCliente)

export default router;