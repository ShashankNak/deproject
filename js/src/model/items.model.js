import mongoose, { Schema } from "mongoose";

const itemSchema = new Schema({
    itemId: {
        required: true,
        type: String, 
    },
    itemName: {
        required: true,
        type: String, 
    },
    description: {
        required: true,
        type: String, 
    },
    itemCategory: {
        required: true,
        type: String, 
    },
    itemKeywords: {
        required: true,
        type: String, 
    },
    expiryDate: {
        required: true,
        type: String, 
    },
    quantityType: {
        required: true,
        type: String, 
    },
    itemImage: {
        required: true,
        type: String, 
    },
},
{
    timestamps: true,
});

const Item = mongoose.models.Item || mongoose.model("Item", itemSchema);


export default Item;