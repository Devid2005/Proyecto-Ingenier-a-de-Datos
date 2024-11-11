// conexion a BD
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// crear el cuerpo de las peticiones a hacer (Middleware)

app.use(express.json());

// conexión BD

mongoose.connect("mongodb://localhost:27017/tallerMongoDB1",{
    useNewURLParser : true,
    useUnifiedTopology: true
}).then(() => console.log('Se conectó a Mongo')) 
.catch(err=> console.error('No se conectó a BD',err));

// Iniciar el servidor

app.listen(PORT,()=>{console.log('servidor ejecutandose sobre el puerto:,${PORT}')});

// ageragar las rutas para manipular user

const User = require('./users');

// crear los usuarios

app.post('/user',async(req,res) => {
    try{
        const user = new user (req.body);
        await user.save();
        res.status(200).sendStatus(user);
    }catch(error){
        res.status(400).send(error);
    }
});

// consultar usuarios

app.get('/user',async(req,res) => {
    try{
        const users = await users.find();
        res.status(200).sendStatus(users);
    }catch(error){
        res.status(500).send(error);
    }
});

// consultar usuario pór nombre

app.get('/user/nombre/:nombre',async(req,res) => {
    try{
        const user = await user.findOne(req.params.nombre);
        if(!user) return response.status(404).send();
        res.status(200).sendStatus(user);
    }catch(error){
        res.status(500).send(error);
    }
});

// buscar todos los usuarios mayores o igales a 30

app.get('/user/edad/:edad',async(req,res) => {
    try{
        const user = await user.find({edad: { $gte: parseInt(req.params.edad)}});
        res.status(200).sendStatus(user);
    }catch(error){
        res.status(400).send(error);
    }
});

// cambiar edad de juan a 31
app.put('/user/Juan',async(req,res) => {
    try{
        const user = await user.UpdateOne({nombre: "Juan Perez"}, {$set:{edad:31}})
        res.status(200).sendStatus(user);
    }catch(error){
        res.status(500).send(error);
    }
});

// activar usuarios mayores a 30

app.put('/user/activos', async(req,res) => {
    try{
        const user = await user.updateMany({edad: { $gte: 30}}, {$set:{activo:true}})
        res.status(200).sendStatus(user);
    }catch(error){
        res.status(500).send(error);
    }    
})

// eliminar usuario luis

app.delete('/user/Luis',async(req,res) => {
    try{
        const user = await user.deleteOne({nombre: "Luis Torres"})
        res.status(200).sendStatus(user);
    }catch(error){
        res.status(500).send(error);
    }
});

// eliminar usuarios menores de 30

app.delete('/user/menores',async(req,res) => {
    try{
        const user = await user.deleteMany({edad:{ $lt: 30}})
        res.status(200).sendStatus(user);
    }catch(error){
        res.status(500).send(error);
    }
});

// ageragar las rutas para manipular productos

const product = require('./products');

// crear los productos

app.post('/product',async(req,res) => {
    try{
        const product = new product (req.body);
        await product.save();
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(400).send(error);
    }
});

// consultar productos

app.get('/product',async(req,res) => {
    try{
        const product = await product.find();
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }
});

// consultar productos pór nombre

app.get('/product/nombre/:nombre',async(req,res) => {
    try{
        const product = await product.findOne(req.params.nombre);
        if(!product) return response.status(404).send();
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }
});

// buscar todos los productos con precio mayor a 100

app.get('/product/precio/:precio',async(req,res) => {
    try{
        const product = await product.find({precio: { $gte: parseInt(req.params.precio)}});
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(400).send(error);
    }
});

// ordenar los productos por precio de manera descendente

app.get('/product/orden/desc',async(req,res) => {
    try{
        const product = await product.find().sort({ precio: -1 })
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }
});

// activar productos

app.put('/product/activos', async(req,res) => {
    try{
        const product = await product.updateMany({}, {$set:{activo:true}})
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }    
})

// desactivar productos con precio mayor a 100

app.put('/product/activos', async(req,res) => {
    try{
        const product = await product.updateMany({precio: { $gte: 100}}, {$set:{activo:false}})
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }    
})

// eliminar productos con precio menor a 50

app.delete('/product/precio/:precio',async(req,res) => {
    try{
        const product = await product.deleteMany({precio: { $lt: 50}}, {$set:{activo:false}})
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    } 
});

// eliminar usuarios menores de 30

app.delete('/product/precio/:precio',async(req,res) => {
    try{
        const product = await product.deleteMany({precio:{ $lt: 30}})
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }
});

// precio promedio de los productos agrupados por categoria 

app.get('/product/promedio', async(req,res) => {
    try{
        const product = await product.aggregate([{ $group: { _id: "$categoria", promedio: { $avg: "$precio" } } }])
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }
});

// categoria con el mayor precio promedio

app.get('/product/categoriaprom', async(req,res) => {
    try{
        const product = await product.aggregate([{ $group: { _id: "$categoria", promedio: { $avg: "$precio" } } }, { $sort: { promedio: -1 } }])
        res.status(200).sendStatus(product);
    }catch(error){
        res.status(500).send(error);
    }
});