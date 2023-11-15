package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIInputText;

using StringTools;

class PlayState extends FlxState
{
    var input:FlxUIInputText;

    var math:FlxText;

    var green:FlxSprite;
    var red:FlxSprite;

    var randomNum1:Int;
    var randomNum2:Int;
    var symbol:Array<String> = ['+', '-', '*', '/'];

    var difficulty:Int = 0;

    // i have no idea how to make these work
    var correctAnswer:String;

    var correct:Bool;
    var incorrect:Bool;

    public function new(diff:Int)
    {
        super();
        difficulty = diff;
    }

    override public function create()
    {
        var bg:FlxSprite = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
        add(bg);

        math = new FlxText(0, 0, 0, '', 12);
        math.setFormat("assets/vcr.ttf", 64, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        math.screenCenter(X);
        add(math);

        input = new FlxUIInputText(10, 10, FlxG.width, '', 8);
	input.setFormat("assets/vcr.ttf", 96, FlxColor.WHITE, FlxTextAlign.CENTER);
	input.alignment = CENTER;
	input.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
	input.screenCenter(XY);
	input.y += 50;
        input.scrollFactor.set();
        input.backgroundColor = 0xFF000000;
        input.lines = 1;
        input.caretColor = 0xFFFFFFFF;
        add(input);

        green = new FlxSprite().makeGraphic(1280, 720, FlxColor.GREEN);
        green.alpha = 0;
        add(green);

        red = new FlxSprite().makeGraphic(1280, 720, FlxColor.RED);
        red.alpha = 0;
        add(red);

        FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

        FlxG.mouse.visible = true;

	randomMath();

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        input.hasFocus = true;

        if (FlxG.keys.justPressed.ENTER && input.text != '')
        {
            randomMath();
        }

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new MenuState());
        }
    }

    function randomMath()
    {
        if (difficulty == 1)
        {
            randomNum1 = FlxG.random.int(0, 20);
            randomNum2 = FlxG.random.int(0, 20);
        }
        else if (difficulty == 0)
        {
            randomNum1 = FlxG.random.int(0, 10);
            randomNum2 = FlxG.random.int(0, 10);
        }

        randomSymbol();

        math.text = 'What is ' + '$randomNum1 $symbol $randomNum2' + ' ?';
        input.text = '';
    }

    function randomSymbol()
    {
        var chance:Int = FlxG.random.int(0, symbol.length - 1);
        var str:String = symbol[chance];
        return str;
    }
}
