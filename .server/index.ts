import { Server } from "colyseus";
import { RoomBasic } from "./RoomBasic";
const port = 23632

/**
Copyright 2022 DillyzThe1

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
**/

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

console.log("made server on ws://localhost:" + port);
