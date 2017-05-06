package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Phone extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.ld37_phone__png, true, 16, 32);
		animation.add("use", [1]);
		animation.add("free", [0]);
	}
}