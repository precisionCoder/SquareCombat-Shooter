package game.engine
{
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.Bitmap;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import obstacle.bullet.Bullet;
	import obstacle.ship.*;
	
	/**
	 * This class controls movement for the player using the keyboard as an input
	 * The Controls are the arrow keys for movement and space to fire
	 * By setting flags for arrows it allows multiple keys to be used simultaneously
	 * to direct the ship.
	 * 
	 * "Control me! Me! That is a feat no one has ever managed"
	 * -Krasmak the Cruel
	 * 
	 * @author William Drescher
	 * 
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class KeyboardControl
	{		
		//Movement Flags
		private var leftArrow:Boolean = false;
		private var rightArrow:Boolean = false;
		private var upArrow:Boolean = false;
		private var downArrow:Boolean = false;
		private var space:Boolean = false;
		
		//Other tools
		private var heroShip:HeroShip;
		private var heroDetector:CollisionDetector;
		private var heroMovement:HeroMovement;
		private var stage:Stage;
		
		//Bullet Image
		[Embed(source="../../images/bullet.png")]
		private var bulletEmbedImage:Class;
		private var bulletImage:Bitmap = new bulletEmbedImage();
		
		//Timer
		private var fireTimer:Timer; //causes delay between fires
		private var canFire:Boolean = true; //can you fire a bullet
		
		public function KeyboardControl(heroShip:HeroShip, collisionDetector:CollisionDetector, stage:Stage)
		{
			this.heroShip = heroShip;
			this.heroDetector = collisionDetector;
			this.heroMovement = new HeroMovement(heroShip);
			this.stage = stage;			
		}
		
		//Adds the movement event listeners to the stage
		public function addMovementHandlers(stage:Stage):void
		{		
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHit);
			stage.addEventListener(KeyboardEvent.KEY_UP, noKeyHit);
			stage.addEventListener(Event.ENTER_FRAME, moveShip);
			fireTimer = new Timer(300, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true)
		}
		
		//Removes the movement event listeners from the stage
		public function removeMovementHandlers(stage:Stage):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyHit);
			stage.removeEventListener(KeyboardEvent.KEY_UP, noKeyHit);
			stage.removeEventListener(Event.ENTER_FRAME, moveShip);
			stage.removeEventListener(TimerEvent.TIMER, fireTimerHandler);
		}
		
		//Sets the flags for the various keys
		private function keyHit(event:KeyboardEvent):void
		{
			//Selects different options according to the key pressed
			//Primarily movement but also shooting
			switch (event.keyCode)
			{
				case Keyboard.SPACE: 
					if (canFire)
					{
						space = true;
					}
					break;
				case Keyboard.RIGHT: 
					rightArrow = true;
					break;
				case Keyboard.LEFT: 
					leftArrow = true;
					break;
				case Keyboard.UP: 
					upArrow = true;
					break;
				case Keyboard.DOWN: 
					downArrow = true;
					break;
			}
		}
		
		//noKeyHit controls what happens if a key is not pressed down
		//Makes sure the hero stops moving when no key is pressed
		private function noKeyHit(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.RIGHT: 
					rightArrow = false;
					break;
				case Keyboard.LEFT: 
					leftArrow = false;
					break;
				case Keyboard.UP: 
					upArrow = false;
					break;
				case Keyboard.DOWN: 
					downArrow = false;
					break;
				case Keyboard.SPACE: 
					space = false;
					break;
			}
		}
		
		//Handles the actual movement of the ship
		private function moveShip(event:Event):void
		{
			if (upArrow && !leftArrow && !rightArrow)
			{
				heroMovement.goUp(heroDetector);
			}
			if (upArrow && leftArrow && !rightArrow)
			{
				heroMovement.goUpLeft(heroDetector);
			}
			if (upArrow && rightArrow && !leftArrow)
			{
				heroMovement.goUpRight(heroDetector);
			}
			if (downArrow && !leftArrow && !rightArrow)
			{
				heroMovement.goDown(heroDetector);
			}
			if (downArrow && leftArrow && !rightArrow)
			{
				heroMovement.goDownLeft(heroDetector);
			}
			if (downArrow && rightArrow && !leftArrow)
			{
				heroMovement.goDownRight(heroDetector);
			}
			if (leftArrow && !upArrow && !downArrow)
			{
				heroMovement.goLeft(heroDetector);
			}
			if (rightArrow && !upArrow && !downArrow)
			{
				heroMovement.goRight(heroDetector);
			}
			if (space && canFire)
			{
				var heroBullet:Bullet = new Bullet(heroShip, 5, 7, bulletImage, stage, heroDetector);
				canFire = false;
				
				//Starts the fire delay to prevent the ship from constantly shooting
				fireTimer.start(); 
			}
		}
		
		//Allows the ship to fire again once the fire delay ends
		private function fireTimerHandler(e:TimerEvent):void
		{
			canFire = true;
		}
	
	}

}