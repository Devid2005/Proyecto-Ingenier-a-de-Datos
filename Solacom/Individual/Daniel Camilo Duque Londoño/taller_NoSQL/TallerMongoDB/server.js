import {config} from 'dotenv'
import express, {json} from 'express'
import path from 'path'

import { __dirname } from './util/__dirname.js'
import { connectDatabase }from './config/database.js'
import usuariosRoutes from './routes/usuariosRoutes.js'
import productosRoutes from './routes/productosRoutes.js'

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

server.use(express.urlencoded({extended:true}));
server.use(express.static('public')); // cuando hay interfaz grafica

// configurar el motor de plantillas
server.set('view engine','ejs')
server.set('views', path.join(__dirname,'views'));
server.use(json())

// configurar rutas de acceso 

server.use(usuariosRoutes)
server.use(productosRoutes)

server.listen(Port, ()=> console.log(`server running in port ${Port}`))
