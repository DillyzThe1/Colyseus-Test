package;

import RoomState.PeterData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;
import lime.app.Application;

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

// https://github.com/colyseus/colyseus-haxe/blob/master/example/openfl/Source/Main.hx
class PlayState extends FlxState
{
	public var heyPeter:Map<String, LerpedSprite>;
	public var lastLastUpdateMS:Float = 0;

	override public function create()
	{
		super.create();
		heyPeter = new Map<String, LerpedSprite>();

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
		Main.room.state.peters.onChange = function(player, key)
		{
			// trace('update peter $key');
			heyPeter[key].intX = player.x;
			heyPeter[key].intY = player.y;
		};
		Main.room.state.peters.onRemove = function(player, key)
		{
			trace('no more peter $key');
			var pg = heyPeter[key];
			remove(pg);
			pg.destroy();
		};
		Main.room.onStateChange += function(state:RoomState)
		{
			// trace('stage cahnge: $state');

			for (i in 0...state.peters.length)
			{
				var curpeter:PeterData = state.peters.getByIndex(i);
				heyPeter[curpeter.id].intX = curpeter.x;
				heyPeter[curpeter.id].intY = curpeter.y;
			}

			if (state.lastUpdateMS != lastLastUpdateMS)
			{
				lastLastUpdateMS = state.lastUpdateMS;
				Application.current.window.title = 'Colyseus Test (Ping: ${Math.floor(Sys.time() * 1000 - state.lastUpdateMS)}ms)';
			}
		};
		Main.room.onError += function(code:Int, message:String)
		{
			trace('connection error: ${message} (code ${code})');
		};
		Main.room.onLeave += function()
		{
			trace('no more room');
			Sys.exit(0);
		};

		/*Main.room.onMessage("ping", function(ms:Float)
			{
				Application.current.window.title = 'Colyseus Test (Ping: ${Math.floor(Sys.time() * 1000 - ms)}ms) ${Sys.time() * 1000} $ms';
		});*/
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
