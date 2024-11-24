import express from "express";
import { GenerarFacturaCliente, GenerarFacturaProvedor} from "../controller/rqfController.js";

const router = express.Router();

// Ruta para generar la factura a partir del ID del pedido
router.get("/facturaCliente/:IdCliente", GenerarFacturaCliente);
router.get("/facturaProvedor/:IdPedidoProvedor", GenerarFacturaProvedor);
export default router;
