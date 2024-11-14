import { Router } from 'express'
import { CrearProvedor, obtenerProvedores, EditarProvedor, EliminarProvedor} from "../controller/ProvedorController.js";
const router = Router()

router.get('/Provedor', obtenerProvedores)
router.post('/Provedor', CrearProvedor)
router.put('/Provedor', EditarProvedor)
router.delete('/Provedor', EliminarProvedor)

export default router;