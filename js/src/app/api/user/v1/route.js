import connectToMongo from "@/db/page";
import { NextResponse } from "next/server";
import User from "@/model/user.model";

export default async function POST(request) {
    try {
        const data = await request.json();
        await connectToMongo();
        await User.create(data);
        return NextResponse.json({message: "User Created"}, {success: true}, {status: 201});
    } catch (error) {
        NextResponse.json({message: `Error Occured - ${error}`}, {success: false}, {status: 400})
    }
}