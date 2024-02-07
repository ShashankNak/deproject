import mongoose, { Schema } from "mongoose";

const userSchema = new Schema({
    email: {
        required: true,
        type: String,
        unique: true,
    },
    password: {
        required: true,
        type: String, 
    },
},
{
    timestamps: true,
});

const User = mongoose.models.User || mongoose.model("User", userSchema);


export default User;