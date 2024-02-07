import mongoose from "mongoose";

const connectToMongo = async() => {
    try {
        await mongoose.connect(process.env.MONGO_DB_URI);
    } catch (error) {
        console.log(`Error occured ${error}`)
    }
}

export default connectToMongo;