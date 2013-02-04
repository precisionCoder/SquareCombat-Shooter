package game.engine.main
{
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.engine.TextBlock;
	import flash.text.TextField;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.media.Sound;
	
	//My Classes
	import game.engine.screen.CollisionDetector;
	import game.engine.screen.ScreenManager;
	import game.engine.input.KeyboardControl;
	import game.engine.object.HeroShip;
	import game.engine.object.EnemyShip;
	import game.engine.movement.DirectionNormalizer;
	import game.engine.screen.ScreenLoader;
	import game.engine.assets.StartScreenImageManager;
	import game.engine.assets.GameScreenImageManager;
	import game.engine.assets.GameOverScreenImageManager;
	import game.engine.assets.SoundManager;
	
	/**
	 * This is the main part of the shooter game, it launches the various screens, initializes needed classes,
	 * and controls game flow
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class ShooterGameManager
	{
		//Add game engine components
		private var gameCollisionDetector:CollisionDetector;
		private var screenManager:ScreenManager;
		private var heroKeyboardControl:KeyboardControl;
		
		//Add timers
		private var gameTimer:Timer;
		private var spawnTimer:Timer;
		
		private var heroShip:HeroShip;
		private var stage:Stage;
		private var screenArea:Sprite;
		private var gameArea:Sprite;
		private var coverScreen:Sprite;
		private var scoreBar:Sprite;
		private var scoreBarText:TextField;
		private var healthBar:Sprite;
		private var gameInitialized:Boolean;
		private var pauseMessage:TextField;
		private var difficulty:Number;
		private var lifeArray:Array;
		private var topBar:Sprite;
		
		public function ShooterGameManager(stage:Stage)
		{
			this.stage = stage;
			lifeArray = new Array();
			gameCollisionDetector = new CollisionDetector();
			screenManager = new ScreenManager();
			gameInitialized = false;
			difficulty = 1.00;
		}
		
		private function initGame(spawnTime:int):void
		{
			StartScreenImageManager.init();
			GameScreenImageManager.init();
			GameOverScreenImageManager.init();
			loadScreen();
			initPlayer();
			
			//Adds player keyboard movement controls
			heroKeyboardControl = new KeyboardControl(heroShip, screenManager, gameArea, stage, this);
			
			//Add game flow timer this will control enemy ships and bullet movement.
			gameTimer = new Timer(25);
			gameTimer.addEventListener(TimerEvent.TIMER, gameTick, false, 0, true);
			
			//Add spawn timer for enemies
			spawnTimer = new Timer(spawnTime);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnTick, false, 0, true);
			
			gameInitialized = true;
		}
		
		//Loads all the screen basics such as the gameArea, and score and healthbars
		private function loadScreen():void
		{
			var screenLoader:ScreenLoader = new ScreenLoader(stage);
			screenArea = screenLoader.loadScreen();
			stage.addChild(screenArea);
			gameArea = screenLoader.loadGameScreen();
			screenArea.addChild(gameArea);
			var gameFrame:Sprite = screenLoader.loadGameFrame();
			screenArea.addChild(gameFrame);
			topBar = screenLoader.loadTopBar();
			screenArea.addChild(topBar)
			healthBar = screenLoader.loadHealthBar();
			screenArea.addChild(healthBar);
			scoreBar = screenLoader.loadScoreBar();
			screenArea.addChild(scoreBar);
			scoreBarText = screenLoader.loadScoreBarText();
			screenArea.addChild(scoreBarText);
			coverScreen = screenLoader.loadStartScreen(this);
			screenArea.addChild(coverScreen);
		}
		
		//Creates the heroship and adds it to the screen manager
		private function initPlayer():void
		{
			//Create player
			var heroImage:Bitmap = new Bitmap(GameScreenImageManager.getBasicHeroImage());
			heroShip = new HeroShip(heroImage, 5, 2, gameArea);
			var heroX:uint = Math.round((gameArea.width - (heroImage.width / 2)) / 2);
			var heroY:uint = Math.round((gameArea.height - (heroImage.height / 2)) / 2);
			heroShip.setAbsoluteX(heroX);
			heroShip.setAbsoluteY(heroY);
			heroShip.setDirection("up");
			heroShip.addToScreen(heroX, heroY);
			screenManager.setHeroShip(heroShip);
			DirectionNormalizer.normalize(heroShip);
		}
		
		public function startGame(spawnTime:int):void
		{
			if (!gameInitialized)
			{
				SoundManager.playWelcomeToSquareShooter();
				initGame(spawnTime);
			}
			else
			{
				SoundManager.playGameStart();
				resetGame();
				screenArea.removeChild(coverScreen);
				heroKeyboardControl.initializeKeyboardControl(this.stage);
				gameTimer.start();
				spawnTimer.start();
			}
		}
		
		public function stopGame():void
		{
			heroKeyboardControl.stopKeyboardControl(this.stage);
			gameTimer.stop();
			spawnTimer.stop();
		}
		
		public function pauseGame():void
		{
			gameTimer.stop();
			spawnTimer.stop();
			
			//Add pause message
			pauseMessage = new TextField();
			pauseMessage.text = "Paused";
			var myFormat:TextFormat = new TextFormat();
			myFormat.color = 0xAA0000;
			myFormat.size = 45;
			pauseMessage.setTextFormat(myFormat);
			myFormat.italic = true;
			pauseMessage.autoSize = TextFieldAutoSize.CENTER;
			gameArea.addChild(pauseMessage);
			pauseMessage.x = (gameArea.width / 2) - (pauseMessage.textWidth / 2);
			pauseMessage.y = (gameArea.height / 3) - (pauseMessage.textHeight / 2);
		}
		
		public function unpauseGame():void
		{
			gameTimer.start();
			spawnTimer.start();
			gameArea.removeChild(pauseMessage);
		}
		
		public function resetGame():void
		{
			screenManager.removeAllBullets();
			screenManager.removeAllEnemyShips();
			resetPlayer(heroShip, gameArea);
			difficulty = 1.00;
		}
		
		//Perform all the neccessary game actions that should happen each round
		private function gameTick(e:TimerEvent):void
		{
			var gameRunning:Boolean = true;
			//Check that game is still running
			if (heroIsDead())
			{
				SoundManager.playGameOver();
				gameRunning = false;
			}
			
			//Adds the top bar items
			var lives:int = heroShip.getHealth();
			var lifePosition:int = (healthBar.width / 2) - 25;
			
			if (lifeArray.length != heroShip.getHealth())
			{
				//Remove old life images
				for (var i:int = 0; i < lifeArray.length; i++)
				{
					var image:Bitmap = lifeArray[i];
					screenArea.removeChild(image);
				}
				
				lifeArray = new Array();
				
				//Add life images
				for (i = 0; i < lives; i++)
				{
					var lifeImage:Bitmap = new Bitmap(GameScreenImageManager.getBasicHeroImage());
					lifeImage.width = lifeImage.width / 1.5;
					lifeImage.height = lifeImage.height / 1.5;
					lifeImage.x = lifePosition;
					lifeImage.y = (topBar.height / 2) - (lifeImage.height / 2);
					lifeArray.push(lifeImage);
					screenArea.addChild(lifeImage);
					lifePosition += lifeImage.width;
				}
				
			}
			
			scoreBarText.text = heroShip.getScore().toString();
			
			if (gameRunning)
			{
				//Move bullets
				screenManager.moveBullets();
				screenManager.moveEnemyShips();
			}
		}
		
		//Spawn a new enemy ship in a random location on a random wall
		//if Math.round(difficulty) is given for the EnemyShip speed then speed of ships will increase over time
		//the same can be done with health but is not currently implemented since it makes it more fun not to have it
		private function spawnTick(e:TimerEvent):void
		{
			var enemyImage:Bitmap = new Bitmap(GameScreenImageManager.getBasicEnemyImage());
			var enemyShip:EnemyShip = new EnemyShip(enemyImage, 5, 1, gameArea);
			var spawnLocation:Point = chooseSpawnPoint(enemyImage);
			enemyShip.addToScreen(spawnLocation.x, spawnLocation.y);
			screenManager.addEnemyShipToScreen(enemyShip);
			difficulty += 0.01;
		}
		
		//Randomly decide a spawnpoint on a wall for a new enemy to spawn
		private function chooseSpawnPoint(enemyImage:Bitmap):Point
		{
			var x:int = Math.floor(Math.random() * (gameArea.width + 1));
			var y:int = Math.floor(Math.random() * (gameArea.height + 1));
			
			//Generate a wall that the enemies will come from
			var wall:uint = Math.floor(Math.random() * 4 + 1);
			
			switch (wall)
			{
				case 1: 
					x = 0;
					break;
				
				case 2: 
					x = gameArea.width - enemyImage.width;
					break;
				
				case 3: 
					y = 0;
					break;
				
				case 4: 
					y = gameArea.height - enemyImage.height;
					break;
			}
			
			var spawnPoint:Point = new Point(x, y);
			return spawnPoint;
		}
		
		private function heroIsDead():Boolean
		{
			if (heroShip.getDead())
			{
				stopGame();
				var screenLoader:ScreenLoader = new ScreenLoader(stage);
				coverScreen = screenLoader.loadGameOverScreen(this, heroShip);
				screenArea.addChild(coverScreen);
				return true;
			}
			return false;
		}
		
		private function resetPlayer(heroShip:HeroShip, gameArea:Sprite):void
		{
			//Create player
			heroShip.setHealth(5);
			heroShip.setSpeed(5);
			heroShip.setDead(false);
			heroShip.setScore(0);
			var heroX:uint = Math.round((gameArea.width - (heroShip.getImage().width / 2)) / 2);
			var heroY:uint = Math.round((gameArea.height - (heroShip.getImage().height / 2)) / 2);
			heroShip.setAbsoluteX(heroX);
			heroShip.setAbsoluteY(heroY);
			heroShip.setDirection("up");
			heroShip.addToScreen(heroX, heroY);
			DirectionNormalizer.normalize(heroShip);
		}
	}
}