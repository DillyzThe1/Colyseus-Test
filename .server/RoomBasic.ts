import http, { request } from "http";
import { Room, Client } from "colyseus";
import { Schema, type, MapSchema } from "@colyseus/schema";

// https://docs.colyseus.io/colyseus/server/room/

export class Peter extends Schema { 
    @type("number") x = 0;
    @type("number") y = 0;
    @type("string") id = "";
}

export class RoomState extends Schema { 
    @type({map: Peter}) petermap = new MapSchema<Peter>();

    movePeter(id:string, movement:any) {
        if (movement.x)
            this.petermap.get(id).x += movement.x;
        else if (movement.y)
            this.petermap.get(id).y += movement.y;
    }

    @type("number") lastUpdateMS = 0;
    updateMS() {
        if (!this.activeMS)
            return;
        //console.log("ms update " + this.lastUpdateMS);

        var timeMS = Math.round(new Date().getTime());
        this.lastUpdateMS = timeMS;
    }

    activeMS:boolean = false;
    startMSUpdater() {
        if (this.activeMS)
            return;
        this.activeMS = true;
        this.updateMS();
    }

}

export class RoomBasic extends Room<RoomState> {
    maxClients = 3;
    theRoomState:RoomState;
    // When room is initialized
    onCreate (options: any) { 
        console.log("new room created! " + this.roomId + " " + this.roomName);

        this.theRoomState = new RoomState();
        this.setState(this.theRoomState);

        this.onMessage("move", (client, data) => {
            this.theRoomState.movePeter(client.id, data);
        });
        this.theRoomState.startMSUpdater();

        function updateMS(room:RoomBasic, state:RoomState) {
            if (!state.activeMS)
                return;
            state.updateMS();
           // for (var i = 0; i < room.clients.length; i++)
            //    room.clients[i].send("ping", {ms: state.lastUpdateMS});
            setTimeout(function() {updateMS(room, state);}, 1500);
        }
        updateMS(this, this.theRoomState);
    }

    GAME_TOKEN:string = "d13354db-c027-40a8-8228-ef16f0ea4a4b";
    // Authorize client based on provided options before WebSocket handshake is complete
    onAuth (client: Client, options: any, request: http.IncomingMessage):boolean { 
        if (options.authToken != this.GAME_TOKEN)
        {
            console.log(client.id + "(" + request.socket.remoteAddress + ") rejected! (reason: invalid or non-existent auth token)");
            return false;
        }
        console.log(client.id + "(" + request.socket.remoteAddress + ") authenticated!");
        return true;
    }

    // When client successfully join the room
    onJoin (client: Client, options: any, auth: any) {
        console.log(client.id + " joined!");

        var peta = new Peter();
        peta.id = client.id;
        this.theRoomState.petermap.set(client.id, peta);
     }

    // When a client leaves the room
    onLeave (client: Client, consented: boolean) { 
        console.log(client.id + " left " + (consented ? "with" : "without") + " consent!");
        this.theRoomState.petermap.delete(client.id);
    }

    // Cleanup callback, called after there are no more clients in the room. (see `autoDispose`)
    onDispose () { 
        this.theRoomState.activeMS = false;
        console.log("killing self! " + this.roomId + " " + this.roomName);
    }
}