package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

/**
 * ...
 * @author SoKette
 */
class PlayState extends FlxState
{
	var _outside:FlxSprite;
	var _room:FlxSprite;

	var _sofa:Sofa;
	var _door:Door;
	var _phone:Phone;
	
	var _player:Player;
	var _pizzaBoy:Delivery;
	
	var _hud:HUD;
	var _phoneHud:PhoneHUD;
	
	override public function create():Void
	{
		//reset score
		Reg.SCORE = 0;
		Reg.TIRED = 0;
		Reg.BORED = 0;
		Reg.HUNGRY = 0;
		Reg.MONEY = 300;
		Reg.ENDED = false;
		
		// declare stuff
		_outside = new FlxSprite(0, 0, AssetPaths.ld37_outside__png);
		_room = new FlxSprite(0, 0, AssetPaths.ld37_room__png);
		_sofa = new Sofa(34, 90);
		_door = new Door(187, 70);
		_phone = new Phone(92, 90);
		_player = new Player(132 , 92);
		_pizzaBoy = new Delivery();
		_hud = new HUD();
		_phoneHud = new PhoneHUD();
		
		// add stuff
		add(_outside);
		add(_pizzaBoy);
		add(_room);
		add(_sofa);
		add(_door);
		add(_phone);
		add(_player);
		add(_hud);
		add(_phoneHud);
		
		_pizzaBoy.visible = false;
		_phoneHud.visible = false;
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (!Reg.ENDED)
		{
			// EXTRA CONTROLS
			control();
			
			// USING OBJECTS MECHANICS
			usingObjects();
			
			// UPDATING HUD
			_hud.updateHUD();
			
			if (_door.opened)
			{
				if (_pizzaBoy.waiting)
				{
					_pizzaBoy.visible = true;
				}
			}
			else if (!_door.opened)
			{
				_pizzaBoy.visible = false;
			}
		}
		super.update(elapsed);
	}
	
	private function control():Void
	{
		if (_player.pressingUse())
		{
			// SOFA
			if (FlxG.overlap(_sofa, _player))
			{
				doSofa();
			}
			// DOOR
			else if (	(FlxG.overlap(_door, _player) && !_pizzaBoy.visible) ||
						(FlxG.overlap(_door, _player) && !_pizzaBoy.hasPizza))
			{
				doDoor();
			}
			// PHONE
			else if (FlxG.overlap(_phone, _player))
			{
				doPhone();
			}
			// PIZZABOY
			else if (FlxG.overlap(_pizzaBoy, _player) && _pizzaBoy.hasPizza)
			{
				doPizzaBoy();
			}
			else
			{
				trace("no object in range");
			}
		}
	}
	
	private function usingObjects():Void
	{	
		// USING PIZZA ORDER
		if (FlxG.overlap(_phone, _player) && (_phoneHud._callProgress == 1))
		{
			if (FlxG.keys.anyJustPressed([G]) && Reg.MONEY >= 20)
			{
				_phoneHud.progressNext();
				// PLAY SOUND
				Reg.MONEY -= 20;
				Reg.SCORE += 20;
				_pizzaBoy.resetBoi();
				_pizzaBoy.waiting = true;
				_player.pizzaType = 0;
			}
			if (FlxG.keys.anyJustPressed([H]) && Reg.MONEY >= 35)
			{
				_phoneHud.progressNext();
				// PLAY SOUND
				Reg.MONEY -= 35;
				Reg.SCORE += 35;
				_pizzaBoy.resetBoi();
				_pizzaBoy.waiting = true;
				_player.pizzaType = 1;
			}
		}
	}
	
	private function doSofa():Void
	{
		if (_player.usingSofa == false)
		{
			#if DEBUG
			trace("player is using sofa");
			#end
			_player.usingSofa = true;
			_sofa.animation.play("use");
			_player.visible = false;
		}
		else
		{
			#if DEBUG
			trace("player left the sofa");
			#end
			_player.usingSofa = false;
			_sofa.animation.play("free");
			_player.visible = true;
		}
	}
	
	private function doDoor():Void
	{
		if (_door.opened == false)
		{
			#if DEBUG
			trace("player opened the door");
			#end
			_door.opened = true;
			_door.animation.play("open");
		}
		else if (_door.opened == true)
		{
			#if DEBUG
			trace("player closed the door");
			#end
			_door.opened = false;
			_door.animation.play("closed");
		}
	}
	
	private function doPhone():Void
	{
		if (_player.usingPhone == false)
		{
			#if DEBUG
			trace("player is using phone");
			#end
			_player.usingPhone = true;
			_phone.animation.play("use");
			_player.visible = false;
			_phoneHud.startCall();
		}
		else if (_player.usingPhone == true && _phoneHud._callProgress < 2)
		{
			_phoneHud.progressNext();
		}
		else
		{
			#if DEBUG
			trace("player left the phone");
			#end
			_player.usingPhone = false;
			_phone.animation.play("free");
			_player.visible = true;
			_phoneHud.visible = false;
		}
	}
	
	// USING DELIVERY BOY (☞ ͡° ͜ʖ ͡°)☞
	private function doPizzaBoy():Void
	{
		if (_player.usingPizza == false)
		{
			#if DEBUG
			trace("player is using pizza");
			#end
			_player.usingPizza = true;
			_pizzaBoy.waiting = false;
			_pizzaBoy.done = true;
			_pizzaBoy.hasPizza = false;
		}
	}
}