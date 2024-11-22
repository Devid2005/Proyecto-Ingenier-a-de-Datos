import { Router } from "express";
import { crearDatos, obtenerDatos } from "../controller/clienteController.js";
const router = Router()

router.get('/clientes', obtenerDatos)
router.post('/clientes', crearDatos)


export default router;