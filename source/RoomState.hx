import io.colyseus.serializer.schema.Schema;
import io.colyseus.serializer.schema.types.*;

class RoomState extends Schema
{
	@:type("map", PeterGriffin)
	public var peters:MapSchema<PeterGriffin> = new MapSchema<PeterGriffin>();
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
