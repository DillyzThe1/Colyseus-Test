import { Server } from "colyseus";
import { RoomBasic } from "./RoomBasic";
const port = 23632

const gameServer = new Server({
    verifyClient: function(info, next) {
        console.log(info);
        console.log(next);
        console.log("client");

        next(true);
    }
});
gameServer.listen(port);
gameServer.define("basic", RoomBasic);

console.log("made the gayme server");
