package;

import RoomState.PeterGriffin;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;

// https://github.com/colyseus/colyseus-haxe/blob/master/example/openfl/Source/Main.hx
class PlayState extends FlxState
{
	public var heyPeter:Map<String, LerpedSprite>;

	override public function create()
	{
		super.create();
		trace('ne wmap');
		heyPeter = new Map<String, LerpedSprite>();

		trace(0);
		Main.room.state.peters.onAdd = function(player, key)
		{
			if (heyPeter.exists(key))
				return;
			trace('hey peter $key');
			var pg = new LerpedSprite().loadGraphic('assets/images/peter.png');
			add(pg);
			heyPeter[key] = pg;
			pg.x = player.x;
			pg.y = player.y;
			pg.intX = player.x;
			pg.intY = player.y;

			player.onChange([]);
		};
		trace(1);
		Main.room.state.peters.onChange = function(player, key)
		{
			// trace('update peter $key');
			heyPeter[key].intX = player.x;
			heyPeter[key].intY = player.y;
		};
		trace(2);
		Main.room.state.peters.onRemove = function(player, key)
		{
			trace('no more peter $key');
			var pg = heyPeter[key];
			remove(pg);
			pg.destroy();
		};
		trace(3);
		Main.room.onStateChange += function(state:RoomState)
		{
			// trace('stage cahnge: $state');

			for (i in 0...state.peters.length)
			{
				var curpeter:PeterGriffin = state.peters.getByIndex(i);
				heyPeter[curpeter.id].intX = curpeter.x;
				heyPeter[curpeter.id].intY = curpeter.y;
			}
		};
		trace(4);
		Main.room.onError += function(code:Int, message:String)
		{
			trace('connection error: ${message} (code ${code})');
		};
		trace(5);
		Main.room.onLeave += function()
		{
			trace('no more room');
			Sys.exit(0);
		};
		trace(6);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var moveAmount:Float = elapsed * 250;
		if (FlxG.keys.pressed.LEFT)
			Main.room.send("move", {x: -moveAmount});
		if (FlxG.keys.pressed.RIGHT)
			Main.room.send("move", {x: moveAmount});
		if (FlxG.keys.pressed.UP)
			Main.room.send("move", {y: -moveAmount});
		if (FlxG.keys.pressed.DOWN)
			Main.room.send("move", {y: moveAmount});
	}
}

class LerpedSprite extends FlxSprite
{
	public var intX:Float = 0;
	public var intY:Float = 0;

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
	}

	public override function update(e:Float)
	{
		super.update(e);

		var moveMount:Float = e * 75;
		if (moveMount < 0.1)
			moveMount = 0.1;
		else if (moveMount > 0.85)
			moveMount = 0.85;
		x = FlxMath.lerp(intX, x, moveMount);
		y = FlxMath.lerp(intY, y, moveMount);
	}

	public override function loadGraphic(Graphic:FlxGraphicAsset, Animated:Bool = false, Width:Int = 0, Height:Int = 0, Unique:Bool = false,
			?Key:String):LerpedSprite
	{
		super.loadGraphic(Graphic, Animated, Width, Height, Unique, Key);
		return this;
	}
}
