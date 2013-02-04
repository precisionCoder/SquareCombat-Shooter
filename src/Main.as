package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import game.engine.main.ShooterGameManager;
	import game.engine.assets.StartScreenImageManager;
	
	//My Classes
	
	
	/**
	 * The main class that starts everything moving
	 *
	 * TODO: Much of this code needs to be factored out into a game management class which
	 * can be started, stopped, and reset easily.  The main class should not contain so much specific code.
	 *
	 * "Even a flood needs a raindrop to start it, never underestimate the power of moving forward"
	 * -Markar the Mighty
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	[SWF(backgroundColor="#F0F0F0")]
	
	public class Main extends Sprite
	{
		private var gameEngine:ShooterGameManager;		
		
		//Main
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//Initialization
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			gameEngine = new ShooterGameManager(stage);
			gameEngine.startGame(1000);
		}
	}

}