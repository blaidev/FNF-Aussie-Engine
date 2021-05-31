package;

import openfl.Lib;
import Options;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var options:Array<OptionCatagory> = [



		new OptionCatagory("Preferences", [
			new FullscreenOption(""),
			new NaughtynessOption(""),
			new DownscrollOption(""),
			new FlashingMenuOption(""),
			new CameraZoomingOnBeatOption(""),
			new FPSOption("")
		]),
		new OptionCatagory("Controls", [
			new DFJKOption(controls)
		
		])
		
		
	];

	private var currentDescription:String = "";
	private var grpControls:FlxTypedGroup<Alphabet>;
	//public var checkBoxesGrp:FlxTypedGroup<FlxSprite>;
	//public var checkBox:FlxSprite;
	//public static var versionShit:FlxText;

	var currentSelectedCat:OptionCatagory;

	override function create()
	{

		

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuDesat"));

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		//checkBoxesGrp = new FlxTypedGroup<FlxSprite>();
		add(grpControls);
		//add(checkBoxesGrp);

		for (i in 0...options.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].getName(), true, false);
			controlLabel.screenCenter();
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);

			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		currentDescription = "";

		//versionShit = new FlxText(5, FlxG.height - 18, 0, "Offset (Left, Right): " + FlxG.save.data.offset + " - Description - " + currentDescription, 12);
		//versionShit.scrollFactor.set();
		//versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//add(versionShit);

		super.create();
	}

	var isCat:Bool = false;

	

	
	public static function truncateFloat( number : Float, precision : Int): Float {
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
		}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

			if (controls.BACK && !isCat)
				FlxG.switchState(new MainMenuState());
			else if (controls.BACK && isCat)
			{
				isCat = false;
				grpControls.clear();
				//checkBoxesGrp.clear(); 
				for (i in 0...options.length)
					{
						var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].getName(), true, false);
						controlLabel.isMenuItem = true;
						controlLabel.screenCenter();
						controlLabel.targetY = i;
						grpControls.add(controlLabel);

						
						// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
					}
				curSelected = 0;
			}
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
			
			if (isCat)
			{

				//for (i in 0...currentSelectedCat.getOptions().length)
				//		{
				//			
				//			if(currentSelectedCat.getOptions()[i].getAccept() == true)
				//			{
				//				checkBoxesGrp[i].animation.play("on", true);
				//			}
				//			else
				//			{
				//				checkBoxesGrp[i].animation.play("off", true);
				//			}
				//			
				//			if(checkBoxesGrp[i].animation.curAnim.name == "on" && checkBoxesGrp[i].animation.curAnim.finished == true)
				//			{
				//				checkBoxesGrp[i].animation.play("onStatic", true);
				//			}
				//			
				//		}

				if (currentSelectedCat.getOptions()[curSelected].getAccept())
				{
					if (FlxG.keys.pressed.SHIFT)
						{
							if (FlxG.keys.pressed.RIGHT)
								currentSelectedCat.getOptions()[curSelected].right();
							if (FlxG.keys.pressed.LEFT)
								currentSelectedCat.getOptions()[curSelected].left();
						}
					else
					{
						if (FlxG.keys.justPressed.RIGHT)
							currentSelectedCat.getOptions()[curSelected].right();
						if (FlxG.keys.justPressed.LEFT)
							currentSelectedCat.getOptions()[curSelected].left();
					}
				}
				
			}
			
		

			if (controls.RESET)
					FlxG.save.data.offset = 0;

			if (controls.ACCEPT)
			{
				if (isCat)
				{
					if (currentSelectedCat.getOptions()[curSelected].press()){
						grpControls.remove(grpControls.members[curSelected]);

						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, currentSelectedCat.getOptions()[curSelected].getDisplay(), true, false);
						ctrl.isMenuItem = true;
						ctrl.centerIsTrue = false;
						grpControls.add(ctrl);
					}
				}
				else
				{

					currentSelectedCat = options[curSelected];
					isCat = true;
					grpControls.clear();
					for (i in 0...currentSelectedCat.getOptions().length)
						{
							var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, currentSelectedCat.getOptions()[i].getDisplay(), true, false);
							controlLabel.isMenuItem = true;
							controlLabel.targetY = i;
							controlLabel.centerIsTrue = false;
							grpControls.add(controlLabel);

							//checkBox = new FlxSprite(30, (70 * i) + 30);
							//checkBox.frames = Paths.getSparrowAtlas("checkboxThingie");
							//checkBox.animation.addByPrefix("off", "Check Box unselected0", 24, true);
							//checkBox.animation.addByPrefix("onStatic", "Check Box Selected Static0", 24, true);
							//checkBox.animation.addByPrefix("on", "Check Box selecting animation0", 24, false);
							
							//heckBoxesGrp.add(checkBox);

							// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
						}
					curSelected = 0;
				}
			}
		FlxG.save.flush();
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent("Fresh");
		#end
		
		FlxG.sound.play(Paths.sound("scrollMenu"), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		//if (isCat)
		//	currentDescription = currentSelectedCat.getOptions()[curSelected].getDescription();
		//else
		//	currentDescription = "Please select a catagory";
		//versionShit.text = "Offset (Left, Right, Shift for slow): " + truncateFloat(FlxG.save.data.offset,2) + " - Description - " + currentDescription;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
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
