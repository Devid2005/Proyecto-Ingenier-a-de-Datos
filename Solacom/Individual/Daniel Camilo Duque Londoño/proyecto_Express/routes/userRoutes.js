import { Router } from "express";
import { crearDatos, obtenerDatos } from "../controller/userController.js";
const router = Router()

router.get('/usuarios', obtenerDatos)
router.post('/usuarios', crearDatos)


export default router;