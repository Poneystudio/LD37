package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Sofa extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.ld37_sofa__png, true, 16, 32);
		animation.add("use", [1, 2, 3, 4, 5, 6, 7]);
		animation.add("free", [0]);
	}
}