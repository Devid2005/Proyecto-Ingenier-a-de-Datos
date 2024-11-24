import {config} from 'dotenv'
import express, {json} from 'express'
import { connectDatabase }from './config/database.js'
import userRoutes from './routes/userRoutes.js'
import servicioRoutes from './routes/servicioRoutes.js'
import provedorRoutes from './routes/provedorRoutes.js'
import productoRoutes from './routes/productoRoutes.js'
import pedidoProvedorRoutes from './routes/pedidoProvedorRoutes.js'
import pedidoClienteRoutes from './routes/pedidoClienteRoutes.js'
import clienteRoutes from './routes/clienteRoutes.js'
import rqfRoutes from './routes/rqfRoutes.js'

config()

// conexion a la BD

connectDatabase()
    .then(()=>{
        console.log('Database connection successful')
    })
    .catch((error)=>{
        console.error('Database connection failed:', error)
        process.exit(1)
    });

// configure server 

const server = express()
const Port = process.env.PORT

server.use(express.json({ limit: '10mb' }));
server.use(express.urlencoded({ limit: '10mb', extended: true }));

server.use(express.urlencoded({extended:true}));
server.use(express.static('public')); // cuando hay interfaz grafica

// configurar rutas de acceso 

server.use(userRoutes)
server.use(servicioRoutes)
server.use(provedorRoutes)
server.use(productoRoutes)
server.use(pedidoProvedorRoutes)
server.use(pedidoClienteRoutes)
server.use(clienteRoutes)
server.use(rqfRoutes)

server.listen(Port, ()=> console.log(`server running in port ${Port}`))

