import { Router } from "express";
import { obtenerProductos,crearProducto,encontrarProductosPorPrecio,ordenarProductosPorPrecio, actualizarEnStockFalseParaCaros, eliminarProducto, eliminarProductosPorPrecio } from "../controller/productController.js";
const router = Router()

router.get('/productos', obtenerProductos); 
router.post('/productos', crearProducto); 
router.get('/caros', encontrarProductosPorPrecio);
router.get('/ordenados-precio', ordenarProductosPorPrecio); 
router.put('/actualizar-en-stock-por-precio', actualizarEnStockFalseParaCaros); 
router.delete('/nombre', eliminarProducto); 
router.delete('/eliminar-por-precio', eliminarProductosPorPrecio); 

export default router;