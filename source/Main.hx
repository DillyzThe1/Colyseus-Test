package;

import flixel.FlxG;
import flixel.FlxGame;
import io.colyseus.Client;
import io.colyseus.Room;
import io.colyseus.error.MatchMakeError;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var client:Client;
	public static var room:Room<RoomState>;

	public function new()
	{
		super();

		var joinFunc = function(error:MatchMakeError, room:Room<RoomState>)
		{
			if (error != null)
			{
				trace('connection error: ${error.message} (code ${error.code})');
				Sys.exit(0);
				return;
			}

			Main.room = room;
			trace('join-edd');
			addChild(new FlxGame(0, 0, PlayState));
			FlxG.autoPause = false;
		};

		client = new Client("ws://localhost:23632");
		client.joinOrCreate("basic", [/* options */], RoomState /* state class */, joinFunc);
	}
}