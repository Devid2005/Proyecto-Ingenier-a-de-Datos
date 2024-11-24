import { Router } from 'express'
import { CrearProvedor, obtenerProvedor, EditarProvedor, EliminarProvedor} from "../controller/ProvedorController.js";
const router = Router()

router.get('/Provedor', obtenerProvedor)
router.post('/Provedor', CrearProvedor)
router.put('/Provedor/:id', EditarProvedor)
router.delete('/Provedor/:id', EliminarProvedor)

export default router;