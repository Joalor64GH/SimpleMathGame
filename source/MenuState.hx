package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	override public function create()
	{
		var titleText:FlxText = new FlxText(0, 0, 0, "The Simple Math Game", 12);
        	titleText.setFormat("assets/vcr.ttf", 64, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		titleText.screenCenter(X);
		add(titleText);

		var easyBtn:FlxButton = new FlxButton(0, FlxG.height / 2 + 50, "Easy", function() 
		{
            	    FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() 
		    {
			FlxG.switchState(new PlayState(0));
		    });
        	});
		easyBtn.scale.set(2, 2);
		easyBtn.screenCenter(X);
		add(easyBtn);

		var hardBtn:FlxButton = new FlxButton(0, easyBtn.y + 70, "Hard", function() 
		{
            	    FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() 
		    {
			FlxG.switchState(new PlayState(1));
		    });
        	});
		hardBtn.scale.set(2, 2);
		hardBtn.screenCenter(X);
		add(hardBtn);

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
