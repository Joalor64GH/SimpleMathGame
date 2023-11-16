package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.ui.FlxUIInputText;

using StringTools;

class PlayState extends FlxState
{
    var input:FlxUIInputText;

    var math:FlxText;

    var randomNum1:Int;
    var randomNum2:Int;
    var correctAnswer:Int;
    var symbol:String;

    var difficulty:Int = 0;

    public function new(diff:Int)
    {
        super();
        difficulty = diff;
    }

    override public function create()
    {
        var bg:FlxSprite = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
        add(bg);

        math = new FlxText(0, 0, FlxG.width, 'Press SPACE to start.', 12);
        math.setFormat("assets/vcr.ttf", 64, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        math.screenCenter(X);
        add(math);

        input = new FlxUIInputText(10, 10, FlxG.width, '', 8);
	input.setFormat("assets/vcr.ttf", 96, FlxColor.WHITE, FlxTextAlign.CENTER);
	input.alignment = CENTER;
	input.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
	input.screenCenter(XY);
	input.y += 50;
        input.backgroundColor = 0xFF000000;
        input.lines = 1;
        input.caretColor = 0xFFFFFFFF;
        add(input);

        FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

        FlxG.mouse.visible = true;

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        input.hasFocus = true;

        if (FlxG.keys.justPressed.ENTER && input.text != '')
        {
            checkAnswer();
        }

        if (FlxG.keys.justPressed.SPACE)
        {
            generateQuestion();
        }

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new MenuState());
        }
    }

    function generateQuestion()
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

        symbol = FlxG.random.bool(50) ? '+' : '-';

        correctAnswer = symbol == '+' ? randomNum1 + randomNum2 : randomNum1 - randomNum2;

        math.text = 'What is ' + '$randomNum1 $symbol $randomNum2' + ' ?';
        input.text = '';
    }

    function checkAnswer()
    {
        var userAnswer:Int = Std.parseInt(input.text);

        if (userAnswer == correctAnswer)
        {
            FlxG.camera.flash(FlxColor.GREEN, 2);
            math.text = 'Correct!';
        }
        else
        {
            FlxG.camera.flash(FlxColor.RED, 2);
            math.text = 'Wrong!';
        }

        new FlxTimer().start(4, generateQuestion, 0);
    }
}