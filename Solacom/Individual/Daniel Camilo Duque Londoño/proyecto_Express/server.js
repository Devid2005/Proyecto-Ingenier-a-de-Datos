import { config } from "dotenv"
import express, {json} from "express"
import path from "path"

import { __dirname } from "./util/__dirname.js"
import { connectDatabase } from "./config/database.js"
import userRoutes from "./routes/userRoutes.js"
config()

// Conexión Base de Datos
connectDatabase()
    .then(() => {
        console.log("Conexión Base de Datos Exitosa")
    })
    .catch((error) => {
        console.error("Error al conectar a la Base de Datos:", error)
        process.exit(1)
    });

// Configuración del servidor
const server = express()
const PORT = process.env.PORT
server.use(express.urlencoded({ extended: true }));
server.use(express.static('public'));

// Configuración del motor de plantillas
server.set('view engine', 'ejs');
server.set('views', path.join(__dirname, 'views'));
server.use(json())

// Configuración Rutas
server.use(userRoutes)


server.listen(PORT, () => console.log(`Server runinn in port ${PORT}`))