import { Router } from 'express'
import { Crearcliente, obtenerClientes, EditarCliente, EliminarCliente} from "../controller/clienteController.js";
const router = Router()

router.get('/Clientes', obtenerClientes)
router.post('/Clientes', Crearcliente)
router.put('/Clientes', EditarCliente)
router.delete('/Clientes', EliminarCliente)

export default router;