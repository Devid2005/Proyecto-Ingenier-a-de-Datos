import { Router } from 'express'
import { CrearProducto, obtenerProductos, EditarProducto, EliminarProducto} from "../controller/ProductoController.js";
const router = Router()

router.get('/Producto', obtenerProductos)
router.post('/Producto', CrearProducto)
router.put('/Producto', EditarProducto)
router.delete('/Producto', EliminarProducto)

export default router;