import fs from 'fs';
import csv from 'csv-parser'
import { MongoClient } from 'mongodb';

async function insertCsvToMongoDB(filePath, collectionName) {
    const uri = `mongodb://${process.env.MONGO_HOST}:${process.env.MONGO_PORT}`;
    const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

    try {
        await client.connect();
        const db = client.db('Solacom');
        const collection = db.collection(collectionName);

        const data = [];

        fs.createReadStream(filePath)
            .pipe(csv())
            .on('data', (row) => {
                data.push(row);
            })
            .on('end', async () => {
                try {
                    const result = await collection.insertMany(data);
                    console.log(`${result.insertedCount} documentos insertados`);
                } catch (error) {
                    console.error('Error al insertar datos:', error);
                } finally {
                    await client.close();
                }
            });
    } catch (error) {
        console.error('Error de conexión a MongoDB:', error);
    }
}

module.exports = insertCsvToMongoDB;
