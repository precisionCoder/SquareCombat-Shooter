package game.engine.Input
{
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import game.engine.Main.ShooterGameManager;
	import game.engine.Movement.HeroMovement;
	import game.engine.Object.Bullet;
	import game.engine.Object.HeroShip;
	import game.engine.Screen.ScreenManager;
	import flash.media.Sound;
	
	/**
	 * This class controls movement for the player using the keyboard as an input
	 * The Controls are the arrow keys for movement, p to pause and space to fire.
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
		//Bullet Image
		[Embed(source="../../images/Bullet.png")]
		private var bulletEmbedImage:Class;
		private var bulletImage:Bitmap = new bulletEmbedImage();
		
		//Bullet Sound
		[Embed(source = '../../sounds/ShootSound.mp3')]
		private var shootEmbedSound:Class;
		private var shootSound:Sound = new shootEmbedSound();
		
		//Movement Flags
		private var leftArrow:Boolean = false;
		private var rightArrow:Boolean = false;
		private var upArrow:Boolean = false;
		private var downArrow:Boolean = false;
		private var space:Boolean = false;
		
		private var screenManager:ScreenManager;
		private var heroMovement:HeroMovement;
		private var shooterGameManager:ShooterGameManager;
		private var gameArea:Sprite;
		private var stage:Stage;
		private var heroShip:HeroShip;
		private var fireTimer:Timer; //causes delay between fires
		private var pauseTimer:Timer;
		private var canFire:Boolean = true; //can you fire a bullet
		private var canPause:Boolean = true;
		private var paused:Boolean = false;
		
		public function KeyboardControl(heroShip:HeroShip, screenManager:ScreenManager, gameArea:Sprite, stage:Stage, shooterGameManager:ShooterGameManager)
		{
			this.heroShip = heroShip;
			this.screenManager = screenManager;
			this.heroMovement = new HeroMovement(heroShip, screenManager);
			this.gameArea = gameArea;
			this.stage = stage;
			this.shooterGameManager = shooterGameManager;
		}
		
		//Adds the movement event listeners to the game area as well as initializes timers
		public function initializeKeyboardControl(stage:Stage):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHit);
			stage.addEventListener(KeyboardEvent.KEY_UP, noKeyHit);
			stage.addEventListener(Event.ENTER_FRAME, moveShip);
			fireTimer = new Timer(400, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true)
			pauseTimer = new Timer(400, 1);
			pauseTimer.addEventListener(TimerEvent.TIMER, pauseTimerHandler, false, 0, true)
		}
		
		//Removes the movement event listeners from the game area
		public function stopKeyboardControl(stage:Stage):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyHit);
			stage.removeEventListener(KeyboardEvent.KEY_UP, noKeyHit);
			stage.removeEventListener(Event.ENTER_FRAME, moveShip);
			stage.removeEventListener(TimerEvent.TIMER, fireTimerHandler);
			
			resetFlags();
		}
		
		private function resetFlags():void
		{
			//Resetting flags avoids a bug when the event listeners are added again
			leftArrow = false;
			rightArrow = false;
			upArrow = false;
			downArrow = false;
			space = false;
		}
		
		//Sets the flags for the various keys
		private function keyHit(event:KeyboardEvent):void
		{
			//Selects different options according to the key pressed
			//Primarily movement but also shooting and pausing
			switch (event.keyCode)
			{
				case 80:
					if (canPause)
					{
						if (paused)
						{
							paused = false;
							shooterGameManager.unpauseGame();
						}
						else
						{
							paused = true;
							shooterGameManager.pauseGame();
							resetFlags();
						}
						canPause = false;
						pauseTimer.start();
					}
					break;
				case Keyboard.SPACE:
					if (canFire && !paused)
					{
						space = true;
					}
					break;
				case Keyboard.RIGHT:
					if (!paused)
					{
						rightArrow = true;
					}
					break;
				case Keyboard.LEFT:
					if (!paused)
					{
						leftArrow = true;
					}
					break;
				case Keyboard.UP:
					if (!paused)
					{
						upArrow = true;
					}
					break;
				case Keyboard.DOWN:
					if (!paused)
					{
						downArrow = true;
					}
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
				heroMovement.goUp(screenManager);
			}
			if (upArrow && leftArrow && !rightArrow)
			{
				heroMovement.goUpLeft(screenManager);
			}
			if (upArrow && rightArrow && !leftArrow)
			{
				heroMovement.goUpRight(screenManager);
			}
			if (downArrow && !leftArrow && !rightArrow)
			{
				heroMovement.goDown(screenManager);
			}
			if (downArrow && leftArrow && !rightArrow)
			{
				heroMovement.goDownLeft(screenManager);
			}
			if (downArrow && rightArrow && !leftArrow)
			{
				heroMovement.goDownRight(screenManager);
			}
			if (leftArrow && !upArrow && !downArrow)
			{
				heroMovement.goLeft(screenManager);
			}
			if (rightArrow && !upArrow && !downArrow)
			{
				heroMovement.goRight(screenManager);
			}
			if (space && canFire)
			{
				//Play firing sound
				shootSound.play();
				
				//Clone the image and use it to make a new bullet
				var bulletImageData:BitmapData = bulletImage.bitmapData;
				var myClone:BitmapData = bulletImageData.clone();
				var myBulletClone:Bitmap = new Bitmap(myClone);
				myBulletClone.scaleX = .5;
				myBulletClone.scaleY = .5;
				
				var heroBullet:Bullet = new Bullet(5, 7, myBulletClone, gameArea, heroShip.getDirection());
				screenManager.addBulletToScreen(heroBullet);
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
		
		//Creates a small delay between pausing and unpausing, or unpausing and pausing preventing the player from accidently double toggling
		private function pauseTimerHandler(e:TimerEvent):void
		{
			canPause = true;
		}
	
	}

}