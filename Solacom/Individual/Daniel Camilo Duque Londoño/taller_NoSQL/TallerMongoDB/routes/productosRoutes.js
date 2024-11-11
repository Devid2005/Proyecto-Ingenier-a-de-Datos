import { Router } from 'express'
import { CrearProductos, obtenerProductos, EditarProductos, EliminarProductos} from "../controller/productosController.js";
const router = Router()

router.get('/Productos', obtenerProductos)
router.post('/Productos', CrearProductos)
router.put('/Productos', EditarProductos)
router.delete('/Productos', EliminarProductos)

export default router;

