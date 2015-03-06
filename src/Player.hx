import starling.core.Starling;
import starling.display.Sprite;
import starling.text.TextField;
import starling.animation.Transitions;
import starling.events.*;
import flash.ui.*;
import Menu;

enum DIRECTION
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
	NONE;
}

class Player extends Sprite
{
	//temporary image
	private var image : TextField;

	private var dir : DIRECTION;
	private var moving : Bool;
	private var game : Game;

	public function new(g : Game)
	{
		super();
		dir = NONE;
		moving = false;
		game = g;

		addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent)
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					dir = UP;
				case Keyboard.DOWN:
					dir = DOWN;
				case Keyboard.LEFT:
					dir = LEFT;
				case Keyboard.RIGHT:
					dir = RIGHT;
			}
		});
		addEventListener(Event.ENTER_FRAME, function()
		{
			if(moving) return;
			switch(dir)
			{
				case LEFT:
					tweenTo(x-Game.GRID_SIZE, y);
				case RIGHT:
					tweenTo(x+Game.GRID_SIZE, y);
				case UP:
					tweenTo(x,y-Game.GRID_SIZE);
				case DOWN:
					tweenTo(x,y+Game.GRID_SIZE);
				default: return;
			}
		});

		addChild(new TextField(Game.GRID_SIZE,Game.GRID_SIZE,"P",Menu.bitmapFont,20,0x0000ff));

	}

	private function tweenTo(nx : Float, ny : Float)
	{
		if(game.validPos(nx,ny))
		{
			moving = true;
			Starling.juggler.tween(this, 0.1,
			{
				transition: Transitions.LINEAR,
				x: nx, y : ny,
				onComplete: function()
				{	moving = false;}
			});
		}
		else Menu.reset();
	}
}