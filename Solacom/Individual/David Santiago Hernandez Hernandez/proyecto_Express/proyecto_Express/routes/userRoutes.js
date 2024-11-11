import { Router } from "express";
import { crearUsuario, obtenerDatos, encontrarUsuarioPorNombre,encontrarUsuarioMayores, actualizarEdadUsuario,activarUsuariosMayores,eliminarUsuarioPorNombre,eliminarUsuariosMenores } from "../controller/userController.js";
const router = Router()

router.get('/usuarios', obtenerDatos)
router.post('/usuarios', crearUsuario)
router.get('/:name', encontrarUsuarioPorNombre);
router.post('/mayores', encontrarUsuarioMayores);
router.put('/actualizar-edad', actualizarEdadUsuario);
router.put('/activar-usuarios', activarUsuariosMayores);
router.delete('/nombre', eliminarUsuarioPorNombre);
router.delete('/eliminar-menores', eliminarUsuariosMenores);

export default router;