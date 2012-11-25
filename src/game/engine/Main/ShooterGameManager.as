package game.engine.Main
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
	
	//My Classes
	import game.engine.Screen.CollisionDetector;
	import game.engine.Screen.ScreenManager;
	import game.engine.Input.KeyboardControl;
	import game.engine.Object.HeroShip;
	import game.engine.Object.EnemyShip;
	import game.engine.Movement.DirectionNormalizer;
	import game.engine.Screen.ScreenLoader;
	
	/**
	 * This game will implement most of the logic to manage the shooting game
	 * This will allow the game flow to be more easily managed as well as stopped and
	 * removed, allowing the game to be extended in other ways (starting menu, shop, etc)
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class ShooterGameManager
	{
		//Add enemy image
		[Embed(source="../../images/Enemy.jpg")]
		private var enemyEmbedImage:Class;
		private var enemyImage:Bitmap = new enemyEmbedImage();
		
		//Add hero image
		[Embed(source="../../images/Hero_Ship.png")]
		private var heroEmbedImage:Class;
		private var heroImage:Bitmap = new heroEmbedImage();
		
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
		private var scoreBar:TextField;
		private var healthBar:TextField;
		private var gameInitialized:Boolean;
		private var pauseMessage:TextField;
		private var difficulty:Number;
		
		public function ShooterGameManager(stage:Stage)
		{
			this.stage = stage;
			gameCollisionDetector = new CollisionDetector();
			screenManager = new ScreenManager();
			gameInitialized = false;
			difficulty = 1.0;
		}
		
		private function initGame(spawnTime:int):void
		{
			loadScreen();
			initPlayer();
			
			//Adds player keyboard movement controls
			heroKeyboardControl = new KeyboardControl(heroShip, screenManager, gameArea, stage, this);
			
			//Add detector for player being dead
			gameTimer = new Timer(25);
			gameTimer.addEventListener(TimerEvent.TIMER, gameTick, false, 0, true);
			
			//Add spawn timer for enemies
			spawnTimer = new Timer(spawnTime);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnTick, false, 0, true);
			
			gameInitialized = true;
		}
		
		private function loadScreen():void
		{
			//Load screens
			var screenLoader:ScreenLoader = new ScreenLoader(stage);
			screenArea = screenLoader.loadScreen();
			stage.addChild(screenArea);
			gameArea = screenLoader.loadGameScreen()
			screenArea.addChild(gameArea);
			healthBar = screenLoader.loadHealthBar()
			screenArea.addChild(healthBar);
			healthBar.text = "Life: ";
			scoreBar = screenLoader.loadScoreBar()
			screenArea.addChild(scoreBar);
			scoreBar.text = "Score: ";
			coverScreen = screenLoader.loadStartScreen(this);
			screenArea.addChild(coverScreen);
		}
		
		private function initPlayer():void
		{
			//Create player
			heroShip = new HeroShip(heroImage, 50, 2, gameArea);
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
				initGame(spawnTime);
			}
			else
			{
				resetGame();
				screenArea.removeChild(coverScreen);
				heroKeyboardControl.addMovementHandlers(this.stage);
				gameTimer.start();
				spawnTimer.start();
			}
		}
		
		public function stopGame():void
		{
			heroKeyboardControl.removeMovementHandlers(this.stage);
			gameTimer.stop();
			spawnTimer.stop();
		}
		
		public function pauseGame():void
		{
			gameTimer.stop();
			spawnTimer.stop();
			
			//Add end game message
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
		}
		
		//Check if the game has ended by the hero dying or achieving the neccessary points
		
		private function gameTick(e:TimerEvent):void
		{
			var gameRunning:Boolean = true;
			//Check that game is still running
			if (heroIsDead())
				gameRunning = false;
			
			//Adds the top bar items
			healthBar.text = "Life: " + heroShip.getHealth();
			scoreBar.text = "Score: " + heroShip.getScore();
			
			if (gameRunning)
			{
				//Move bullets
				screenManager.moveBullets();
				screenManager.moveEnemyShips();
			}
		}
		
		//Spawn a new enemy ship in a random location
		private function spawnTick(e:TimerEvent):void
		{
			var enemyImageData:BitmapData = enemyImage.bitmapData;
			var myClone:BitmapData = enemyImageData.clone();
			var myEnemyClone:Bitmap = new Bitmap(myClone);
			var enemyShip:EnemyShip = new EnemyShip(myEnemyClone, Math.round(difficulty), Math.round(difficulty), gameArea);
			var spawnLocation:Point = chooseSpawnPoint();
			enemyShip.addToScreen(spawnLocation.x, spawnLocation.y);
			screenManager.addEnemyShipToScreen(enemyShip);
			difficulty += 0.1;
		}
		
		//Choose spawning wall
		private function chooseSpawnPoint():Point
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
		
		//Check if hero is dead
		private function heroIsDead():Boolean
		{
			if (heroShip.getDead())
			{
				stopGame();
				var screenLoader:ScreenLoader = new ScreenLoader(stage);
				coverScreen = screenLoader.loadRestartScreen(this, heroShip);
				screenArea.addChild(coverScreen);
				return true;
			}
			return false;
		}
		
		private function resetPlayer(heroShip:HeroShip, gameArea:Sprite):void
		{
			//Create player
			heroShip.setHealth(50);
			heroShip.setSpeed(5);
			heroShip.setDead(false);
			heroShip.setScore(0);
			var heroX:uint = Math.round((gameArea.width - (heroShip.getImage().width / 2)) / 2);
			var heroY:uint = Math.round((gameArea.height - (heroShip.getImage().height / 2)) / 2);
			heroShip.setAbsoluteX(heroX);
			heroShip.setAbsoluteY(heroY);
			heroShip.setDirection("up");
			heroShip.addToScreen(heroX, heroY);
			//screenManager.setHeroShip(heroShip);
			DirectionNormalizer.normalize(heroShip);
		}
	}
}