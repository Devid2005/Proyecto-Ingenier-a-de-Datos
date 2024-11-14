import { Router } from 'express'
import multer from 'multer'
import { CrearUsuarios, obtenerDatos, EditarUsuario, EliminarUsuario,uploadCsv} from "../controller/UserController.js";
const router = Router()
const upload = multer({ dest: 'uploads/' });
// routes/dataRoutes.js

router.post('/upload-csv', upload.single('file'), uploadCsv);
router.get('/usuarios', obtenerDatos)
router.post('/usuarios', CrearUsuarios)
router.put('/usuarios', EditarUsuario)
router.delete('/usuarios', EliminarUsuario)

export default router;

