import connectToMongo from "@/db/page";
import { NextResponse } from "next/server";
import Item from "@/model/items.model";

export async function POST(request) {
    try {
        const data = await request.json();
        await connectToMongo();
        await Item.create(data);
        return NextResponse.json({message: "Item Added"}, {status: 201});
    } catch (error) {
        return NextResponse.json({message: `Error Occured - ${error}`}, {success: false}, {status: 400})
    }
}

export async function GET() {
    try {
        await connectToMongo();
        const items = await Item.find();
        return NextResponse.json({items: items}, {success: true}, {status: 201});
    } catch (error) {
        return NextResponse.json({message: `Error Occured - ${error}`}, {success: false}, {status: 400})
    }
}