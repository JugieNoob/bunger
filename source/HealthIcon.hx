package;

import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var char:String = 'bf';
	public var isPlayer:Bool = false;
	public var isOldIcon:Bool = false;
	public var isOldIcon2:Bool = false;

	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(?char:String = "bf", ?isPlayer:Bool = false)
	{
		super();

		this.char = char;
		this.isPlayer = isPlayer;

		isPlayer = isOldIcon = false;
		isPlayer = isOldIcon2 = false;

		antialiasing = FlxG.save.data.antialiasing;

		changeIcon(char);
		changeIcon2(char);
		scrollFactor.set();
	}

	public function swapOldIcon()
	{
		(isOldIcon = !isOldIcon) ? changeIcon("bf-old") : changeIcon(char);
	}

	public function swapOldIcon2()
		{
			(isOldIcon2 = !isOldIcon2) ? changeIcon2("bf-old-2") : changeIcon2(char);
		}

	public function changeIcon(char:String)
	{
		if (char != 'bf-pixel' && char != 'bf-old')
			char = char.split("-")[0];

		loadGraphic(Paths.image('icons/icon-' + char), true, 150, 150);
		if(char.endsWith('-pixel') || char.startsWith('senpai') || char.startsWith('spirit'))
			antialiasing = false
		else
			antialiasing = FlxG.save.data.antialiasing;
		animation.add(char, [0, 1], 0, false, isPlayer);
		animation.play(char);
	}

	public function changeIcon2(char:String)
		{
			if (char != 'bf-pixel' && char != 'bf-old-2')
				char = char.split("-")[0];
	
			loadGraphic(Paths.image('icons/icon-' + char), true, 150, 150);
			if(char.endsWith('-pixel') || char.startsWith('senpai') || char.startsWith('spirit'))
				antialiasing = false
			else
				antialiasing = FlxG.save.data.antialiasing;
			animation.add(char, [0, 1], 0, false, isPlayer);
			animation.play(char);
		}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
