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
    public var score:Int = 0;

    var scoreTxt:FlxText;

    var input:FlxUIInputText;

    var math:FlxText;

    var randomNum1:Float;
    var randomNum2:Int;
    var correctAnswer:Float;
    var symbol:String;

    var difficulty:Int = 0;

    var timed:Bool;
    var timeLeft:Int;
    var timeTxt:FlxText;

    public function new(diff:Int, ?time:Bool)
    {
        super();
	    
        difficulty = diff;
        timed = time;
    }

    override public function create()
    {
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('background'));
	add(bg);

        math = new FlxText(0, 0, FlxG.width, 'Press SPACE to start.', 12);
        math.setFormat(Paths.font('vcr.ttf'), 64, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        math.screenCenter(X);
        add(math);

        input = new FlxUIInputText(10, 10, FlxG.width, '', 8);
	input.setFormat(Paths.font('vcr.ttf'), 96, FlxColor.WHITE, FlxTextAlign.CENTER);
	input.alignment = CENTER;
	input.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
	input.screenCenter(XY);
	input.y += 50;
        input.backgroundColor = 0xFF000000;
        input.lines = 1;
        input.caretColor = 0xFFFFFFFF;
        add(input);

        scoreTxt = new FlxText(5, FlxG.height - 24, 0, 'Score: $score', 12);
	scoreTxt.scrollFactor.set();
	scoreTxt.setFormat(Paths.font('vcr.ttf'), 26, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	add(scoreTxt);

        timeTxt = new FlxText(5, FlxG.height - 44, 0, 'You get 2 minutes to answer as many question as you can!', 12);
	timeTxt.scrollFactor.set();
	timeTxt.setFormat(Paths.font('vcr.ttf'), 26, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	add(timeTxt);

        if (timed == true)
        {
            timeLeft = 120000; // two minutes
        }

        FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

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

        if (FlxG.keys.justPressed.E) // end game
        {
            FlxG.switchState(new GameOverState(score));
        }

	if (timed == true && FlxG.keys.justPressed.SPACE)
	{
            updateTime();
	}
    }

    function generateQuestion()
    {
        randomNum1 = FlxG.random.int(0, difficulty == 1 ? 20 : 10);
        randomNum2 = FlxG.random.int(0, difficulty == 1 ? 20 : 10);

        var chance:Int = FlxG.random.int(1, 5);

        switch (chance)
        {
            case 1: // addition
                correctAnswer = randomNum1 + randomNum2;
                symbol = '+';
            case 2: // subtraction
                correctAnswer = randomNum1 - randomNum2;
                symbol = '-';
            case 3: // multiplication
                correctAnswer = randomNum1 * randomNum2;
                symbol = '*';
            case 4: // division
                correctAnswer = randomNum1 * randomNum2;
                randomNum1 = correctAnswer; // swap for division
                correctAnswer = randomNum1 / randomNum2;
                symbol = '/';
            case 5: // exponentiation
                correctAnswer = Math.pow(randomNum1, randomNum2);
                symbol = '^';
        }

        math.text = 'What is ' + '$randomNum1 $symbol $randomNum2' + ' ?';
        input.text = '';
    }

    function checkAnswer()
    {
        var userAnswer:Float = Std.parseFloat(input.text);

        if (userAnswer == correctAnswer)
        {
            FlxG.camera.flash(FlxColor.GREEN, 1);
            math.text = 'Correct!';
            updateScore('Score: $score');
            score += 1;
        }
        else
        {
            FlxG.camera.flash(FlxColor.RED, 1);
            math.text = 'Wrong!';
            updateScore('Score: $score');
            score -= 1;
        }

        new FlxTimer().start(2.5, function(tmr:FlxTimer)
	{
	    generateQuestion();
	});
    }

    function updateTime()
    {
        timeLeft -= 1;

        if (timeLeft == 0)
        {
            FlxG.switchState(new GameOverState(score));
        }

        timeTxt.text = 'Time Left: $timeLeft';
    }

    function updateScore(points:String):Void 
    {
	scoreTxt.text = points;
    }
}
