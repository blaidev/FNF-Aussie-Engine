package;

import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;

class OptionCatagory
{
	private var _options:Array<Option> = new Array<Option>();
	public final function getOptions():Array<Option>
	{
		return _options;
	}

	public final function addOption(opt:Option)
	{
		_options.push(opt);
	}

	
	public final function removeOption(opt:Option)
	{
		_options.remove(opt);
	}

	private var _name:String = " New Catagory";
	public final function getName() {
		return _name;
	}

	public function new (catName:String, options:Array<Option>)
	{
		_name = catName;
		_options = options;
	}
}

class Option
{
	public function new()
	{
		display = updateDisplay();
	}
	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;
	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	
	// Returns whether the label is to be updated.
	public function press():Bool { return throw "     stub!"; }
	private function updateDisplay():String { return throw "     stub!"; }
	public function left():Bool { return throw "     stub!"; }
	public function right():Bool { return throw "     stub!"; }
}

class DFJKOption extends Option
{
	private var controls:Controls;

	public function new(controls:Controls)
	{
		super();
		this.controls = controls;
	}

	public override function press():Bool
	{
		FlxG.save.data.dfjk = !FlxG.save.data.dfjk;
		
		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return  FlxG.save.data.dfjk ? " DFJK" : " WASD";
	}
}



class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return " Downscroll " + (FlxG.save.data.downscroll ? "on" : "off");
	}
}







class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fps = !FlxG.save.data.fps;
		(cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return " FPS Counter " + (!FlxG.save.data.fps ? "off" : "on");
	}
}


class FullscreenOption extends Option
{
	//Window mode: Fullscreen/Windowed
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.fullscreen = !FlxG.fullscreen;
		FlxG.save.data.fullscreen = FlxG.fullscreen;
		display = updateDisplay();
		
		return true;
	}

	private override function updateDisplay():String
	{
		return " Window mode -   " + (FlxG.save.data.fullscreen ? "Fullscreen" : "Windowed");
	}
}

class NaughtynessOption extends Option
{
	//Window mode: Fullscreen/Windowed
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		
		FlxG.save.data.naughtyness = !FlxG.save.data.naughtyness;
		display = updateDisplay();
		
		return true;
	}

	private override function updateDisplay():String
	{
		return " Naughtyness " + (FlxG.save.data.naughtyness ? "on" : "off");
	}
}

class FlashingMenuOption extends Option
{
	//Window mode: Fullscreen/Windowed
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		
		FlxG.save.data.flashingMenu = !FlxG.save.data.flashingMenu;
		display = updateDisplay();
		
		return true;
	}

	private override function updateDisplay():String
	{
		return " Flashing Menu " + (FlxG.save.data.flashingMenu ? "on" : "off");
	}
}

class CameraZoomingOnBeatOption extends Option
{
	//Window mode: Fullscreen/Windowed
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		
		FlxG.save.data.cameraZoomingOnBeat = !FlxG.save.data.cameraZoomingOnBeat;
		display = updateDisplay();
		
		return true;
	}

	private override function updateDisplay():String
	{
		return " Camera Zooming On Beat " + (FlxG.save.data.cameraZoomingOnBeat ? "on" : "off");
	}
}









