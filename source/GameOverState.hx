package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

class GameOverState extends FlxState
{
    var finalScore:Int;

    public function new(finalScore:Int)
    {
        super();
        this.finalScore = finalScore;
    }

    override public function create()
    {
        super.create();

        var text:FlxText = new FlxText(0, 0, FlxG.width, 'Game Over!\nYour final score is $finalScore' + '.\nGood Job!', 12);
        text.setFormat(Paths.font('vcr.ttf'), 64, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        text.screenCenter(X);
        add(text);

        var menuBtn:FlxButton = new FlxButton(0, FlxG.height / 2 + 50, "Menu", function() 
	{
            FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() 
	    {
	        FlxG.switchState(new MenuState());
	    });
        });
	menuBtn.scale.set(2, 2);
        menuBtn.label.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        menuBtn.label.screenCenter(XY);
	menuBtn.screenCenter(X);
	add(menuBtn);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}