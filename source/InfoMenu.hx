package;

import openfl.display.BitmapData;
import openfl.system.System;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

import Discord.DiscordClient;

using StringTools;

class InfoMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;
	
	public static var credits:Array<String> = [
	'Jugie (Basically everything)',
	'KadeDev (Kade Engine)',
	'Soft Mod (Info Menu)'
	];

	override function create()
	{
		FlxG.sound.cache('assets/data/senpai/confirmSound.ogg');
		//if (!FlxG.sound.music.playing)
		//{
		//	FlxG.sound.playMusic(Paths.inst('whale-waltz'));
		//}
		
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Inside The Info Menu...", null);

		if(!FlxG.sound.music.playing){
			FlxG.sound.playMusic(Paths.music("SoftConfig", "shared"));
		}
		
		FlxG.autoPause = false;
	
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		add(bg);

		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...credits.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, new EReg('_', 'g').replace(new EReg('0', 'g').replace(credits[i], 'O'), ' '), true, false);
			songText.isMenuItem = true;
			songText.targetY = i;

			if(credits[i].contains(":")){
				songText.color = 0xFFFFFF00;
			}

			grpSongs.add(songText);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.F)
		{
		FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			FlxG.autoPause = true;
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			trace(curSelected);
			switch (curSelected){
				case 0:
					fancyOpenURL("https://www.youtube.com/channel/UCx2_AdEK_5FLp4B7HvPC0Pg");
				case 1:
					fancyOpenURL("https://github.com/KadeDev/Kade-Engine");
				case 2:
					fancyOpenURL("https://twitter.com/tamacoochi");
			}
		}
	}

	function changeSelection(change:Int = 0)
	{

		curSelected += change;

		if (curSelected < 0)
			curSelected = credits.length - 1;
		if (curSelected >= credits.length)
			curSelected = 0;

		var changeTest = curSelected;

		if(credits[curSelected] == "" || credits[curSelected].contains(":") && credits[curSelected] != "PROGRAMMERS:" && credits[curSelected] != "Press Enter For Social:"){
			changeSelection(change == 0 ? 1 : change);
		}

		if(changeTest == curSelected){
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			trace("ayo doep"); // ?????
		}
		

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

	}
}