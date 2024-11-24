import { Router } from 'express'
import multer from 'multer'
import { CrearUsuarios, obtenerUsuarios, EliminarUsuario, EditarUsuario} from "../controller/UserController.js";
const router = Router()

router.post('/usuarios', CrearUsuarios)
router.get('/usuarios', obtenerUsuarios)
router.put('/usuariosNombre/:id', EditarUsuario);
router.delete('/usuarios/:id', EliminarUsuario)

export default router;