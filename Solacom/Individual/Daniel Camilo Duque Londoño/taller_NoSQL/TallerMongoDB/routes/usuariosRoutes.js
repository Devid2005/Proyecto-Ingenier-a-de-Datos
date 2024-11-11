import { Router } from 'express'
import { CrearUsuarios, obtenerDatos, EditarUsuario, EliminarUsuario,EncontarPorNombre} from "../controller/usuariosController.js";
const router = Router()

router.get('/usuarios', obtenerDatos)
router.post('/usuarios', CrearUsuarios)
router.put('/usuarios', EditarUsuario)
router.delete('/usuarios', EliminarUsuario)
router.get('/usuarios/nombre',EncontarPorNombre)

export default router;

