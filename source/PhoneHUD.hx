package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author SoKette
 */
class PhoneHUD extends FlxTypedGroup<FlxSprite>
{
	var _callBg:FlxSprite;
	var _currentDialogue:SktText;
	var _menuBg:FlxSprite;
	var _menuTxt:SktText;
	
	public var _callProgress:Int; // because trying to return the value with a class was somehow impossible.
	
	public function new() 
	{
		super();
		
		_callProgress = 0;
		
		_callBg = new FlxSprite();
		//_callBg.makeGraphic(FlxG.width / 2, FlxG.height / 3, 0xffbbbbbb);
		_callBg.makeGraphic(150, 42, 0xff333643);
		_callBg.x = 10;
		_callBg.y = FlxG.height / 3;
		
		_currentDialogue = new SktText("PLACEHOLDER", 8);
		_currentDialogue.x -= 70;
		_currentDialogue.y -= 10;
		
		_menuBg = new FlxSprite();
		_menuBg.makeGraphic(60, 80, 0xff333643); // TODO: ajuster taille
		_menuBg.x = 170;
		_menuBg.y = FlxG.height / 3;
		
		_menuTxt = new SktText("Margherita\n[G]  20€\n\nHawaiian\n[H]  35€", 8);
		_menuTxt.x = 170;
		_menuTxt.y += 10;
		
		add(_callBg);
		add(_currentDialogue);
		add(_menuBg);
		add(_menuTxt);
		
		_menuBg.visible = false;
		_menuTxt.visible = false;
	}
	
	// PRIVATE FUNCTIONS
	private function phoneCall():Void
	{
		switch (_callProgress) 
		{
			case 0:
				_currentDialogue.text = "Hello, pizza awesome here,\nwe do the best pizza !";
			case 1:
			{
				_currentDialogue.text = "Want a pizza ? Sure !\nWhich one ?";
				_menuBg.visible = true;
				_menuTxt.visible = true;
			}
			case 2:
			{
				_currentDialogue.text = "Alright sir, you pizza should\narrive... Now !";
				_menuBg.visible = false;
				_menuTxt.visible = false;
			}
		}
	}
	
	// PUBLIC FUNCTIONS
	public function startCall():Void
	{
		_currentDialogue.text = "Hello, pizza awesome here,\nwe do the best pizza !";
		_callProgress = 0;
		visible = true;
	}
	
	public function progressNext():Void
	{
		_callProgress++;
		phoneCall();
	}
	
	// FUCK YOU HAXE, SERIOUSLY.
	// THIS DOES NOT RETURN AN INT, THIS RETURN #FUNCTION:0
	// PLEASE SEND HELP, I DUMDUM.
	//public function get_callProgress():Int
	//{
		//if (_callProgress == 0)
			//return 0;
		//else if (_callProgress == 1)
			//return 1;
		//else if (_callProgress == 2)
			//return 2;
		//return 3;
	//}
}