import { Router } from 'express'
import { CrearServicio, obtenerServicios, EditarServicio, EliminarServicio} from "../controller/servicioController.js";
const router = Router()

router.post('/Servicios', CrearServicio)
router.get('/Servicios', obtenerServicios)
router.put('/Servicios/:id', EditarServicio)
router.delete('/Servicios/:id', EliminarServicio)

export default router;