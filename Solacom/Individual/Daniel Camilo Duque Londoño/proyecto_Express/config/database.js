import { connect } from "mongoose"
import { config } from "dotenv";
config()
export const connectDatabase = async () => {
    try {
        // const conection = await connect(`mongodb://${process.env.MONGO_USER}:${process.env.MONGO_PASSWORD}@${process.env.MONGO_HOST}:${process.env.MONGO_PORT}/${process.env.MONGO_DB}?authSource=admin`);
        const conection = await connect(`mongodb://${process.env.MONGO_HOST}:${process.env.MONGO_PORT}/${process.env.MONGO_DB}`);
        return conection;
    } catch (error) {
        throw Error("ERROR: " + error.message)
    }
}