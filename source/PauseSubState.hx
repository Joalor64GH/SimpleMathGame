package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

// pause substate i guess
class PauseSubState extends FlxSubState
{
    public function new()
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE);
        bg.alpha = 0.3;
        add(bg);

        var titleText:FlxText = new FlxText(0, 0, 0, "PAUSED?", 12);
        	titleText.setFormat("assets/vcr.ttf", 60, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		titleText.screenCenter(X);
		add(titleText);

		var resumeBtn:FlxButton = new FlxButton(0, FlxG.height / 2 + 50, "Resume", function() 
		{
            close();
        	});
		resumeBtn.scale.set(2, 2);
		resumeBtn.screenCenter(X);
		add(resumeBtn);

		var menuBtn:FlxButton = new FlxButton(0, resumeBtn.y + 70, "Menu", function() 
		{
            	    FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() 
		    {
			FlxG.switchState(new MenuState());
		    });
        	});
		menuBtn.scale.set(2, 2);
		menuBtn.screenCenter(X);
		add(menuBtn);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}