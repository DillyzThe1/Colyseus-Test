import io.colyseus.serializer.schema.Schema;
import io.colyseus.serializer.schema.types.*;

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

class RoomState extends Schema
{
	@:type("map", PeterData)
	public var peters:MapSchema<PeterData> = new MapSchema<PeterData>();
	@:type("number")
	public var lastUpdateMS:Dynamic = 0;
}

class PeterGriffin extends Schema
{
	@:type("number")
	public var x:Dynamic = 0;
	@:type("number")
	public var y:Dynamic = 0;
	@:type("string")
	public var id:Dynamic = "";
}
