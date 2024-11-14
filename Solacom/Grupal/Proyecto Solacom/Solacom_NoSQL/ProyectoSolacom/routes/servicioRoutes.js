import { Router } from 'express'
import { CrearServicio, obtenerServicios, EditarServicio} from "../controller/servicioController.js";
const router = Router()

router.get('/Servicios', obtenerServicios)
router.post('/Servicios', CrearServicio)
router.put('/Servicios', EditarServicio)

export default router;