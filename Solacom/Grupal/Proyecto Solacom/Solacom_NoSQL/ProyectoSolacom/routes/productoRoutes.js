import { Router } from 'express'
import { CrearProducto, obtenerProducto, EditarProducto, EliminarProducto} from "../controller/ProductoController.js";
const router = Router()

router.get('/Producto', obtenerProducto)
router.post('/Producto', CrearProducto)
router.put('/Producto/:id', EditarProducto)
router.delete('/Producto/:id', EliminarProducto)

export default router;