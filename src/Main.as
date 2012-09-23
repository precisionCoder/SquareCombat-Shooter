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
	
	//My Classes
	import obstacle.ship.*;
	import obstacle.bullet.*;
	import game.engine.CollisionDetector;
	import game.engine.DirectionNormalizer;
	import game.engine.KeyboardControl;
	
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
		private var flag:Boolean;
		
		//Add enemy image
		[Embed(source="images/Enemy.jpg")]
		private var enemyEmbedImage:Class;
		private var enemyImage:Bitmap = new enemyEmbedImage();
		
		//Add hero image
		[Embed(source="images/Hero_Ship.png")]
		private var heroEmbedImage:Class;
		private var heroImage:Bitmap = new heroEmbedImage();
		
		//Add game engine components
		private var gameCollisionDetector:CollisionDetector;
		private var heroMovement:KeyboardControl;
		private var enemyMovement:EnemyMovement;
		
		//Add timers
		private var gameTimer:Timer;
		private var spawnTimer:Timer;
		
		private var heroShip:HeroShip;
		
		//Main
		public function Main():void
		{
			gameCollisionDetector = new CollisionDetector();
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
			
			//Extra event listeners
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		//Initialization
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Create player
			heroShip = new HeroShip(heroImage, 50, 5, this.stage);
			var heroX:uint = Math.round((stage.stageWidth - (heroImage.width / 2)) / 2);
			var heroY:uint = Math.round((stage.stageHeight - (heroImage.height / 2)) / 2);
			heroShip.setAbsoluteX(heroX);
			heroShip.setAbsoluteY(heroY);
			heroShip.setDirection("up");
			heroShip.addToStage(heroX, heroY);
			DirectionNormalizer.normalize(heroShip);
			
			//Adds player keyboard movement controls
			heroMovement = new KeyboardControl(heroShip, gameCollisionDetector, stage);
			heroMovement.addMovementHandlers(this.stage);
			
			//Adds enemy movement
			enemyMovement = new EnemyMovement();
			
			//Add enemies to the game
			var enemyArray:Array = new Array();
			var enemyImageData:BitmapData = enemyImage.bitmapData;
			for (var i:uint = 0; i < 3; i++)
			{
				var myClone:BitmapData = enemyImageData.clone();
				var myEnemyClone:Bitmap = new Bitmap(myClone);
				enemyArray[i] = new EnemyShip(myEnemyClone, 20, 5, this.stage);
				var spawnLocation:Point = chooseSpawnPoint();
				enemyArray[i].addToStage(spawnLocation.x, spawnLocation.y);
				gameCollisionDetector.addToCollisionList(enemyArray[i]);
			}
			
			//Add detector for player being dead
			gameTimer = new Timer(25);
			gameTimer.addEventListener(TimerEvent.TIMER, gameTick, false, 0, true);
			gameTimer.start();
			
			//Add spawn timer for enemies
			spawnTimer = new Timer(1000);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnTick, false, 0, true);
			spawnTimer.start();
		}
		
		private function onEnterFrame(ev:Event):void
		{
		}
		
		//Check if the game has ended by the hero dying or achieving the neccessary points
		
		private function gameTick(e:TimerEvent):void
		{
			checkForDeadHero();
			checkForEndOfGame();
			var enemyArray:Array = gameCollisionDetector.getObstacleArray();
			var arrayIndex:uint = 0;
			for each (var enemy:EnemyShip in enemyArray)
			{
				enemyMovement.move(heroShip, enemy);
				if (enemyMovement.checkForCollisions(heroShip, enemy))
				{
					heroShip.takeDamage(10);
					enemy.takeDamage(10);
					if (enemy.getDead())
					{
						heroShip.addScore(1);
						enemyArray.splice(arrayIndex, 1);
					}
				}
				arrayIndex++;
			}
			gameCollisionDetector.setObstacleArray(enemyArray);
		}
		
		//Spawn a new enemy ship in a random location
		private function spawnTick(e:TimerEvent):void
		{
			var enemyArray:Array = new Array();
			var enemyImageData:BitmapData = enemyImage.bitmapData;
			for (var i:uint = 0; i < 1; i++)
			{
				var myClone:BitmapData = enemyImageData.clone();
				var myEnemyClone:Bitmap = new Bitmap(myClone);
				enemyArray[i] = new EnemyShip(myEnemyClone, 20, 5, this.stage);
				var spawnLocation:Point = chooseSpawnPoint();
				enemyArray[i].addToStage(spawnLocation.x, spawnLocation.y);
				gameCollisionDetector.addToCollisionList(enemyArray[i]);
			}
		}
		
		//Choose spawning wall
		private function chooseSpawnPoint():Point
		{
			var x:int = Math.floor(Math.random() * (stage.stageWidth + 1));
			var y:int = Math.floor(Math.random() * (stage.stageHeight + 1));
			
			//Generate a wall that the enemies will come from
			var wall:uint = Math.floor(Math.random() * 4 + 1);
			
			switch (wall)
			{
				case 1: 
					x = 0 - enemyImage.width;
					break;
				
				case 2: 
					x = stage.stageWidth;
					break;
				
				case 3: 
					y = 0 - enemyImage.height;
					break;
				
				case 4: 
					y = stage.stageHeight;
					break;
			}
			
			var spawnPoint:Point = new Point(x, y);
			return spawnPoint;
		}
		
		//Check if hero is dead
		private function checkForDeadHero():void
		{
			if (heroShip.getDead())
			{
				heroMovement.removeMovementHandlers(this.stage);
				var deathText:TextField = new TextField();
				stage.addChild(deathText);
				deathText.text = "You have died!";
				var myFormat:TextFormat = new TextFormat();
				myFormat.color = 0xAA0000;
				myFormat.size = 24;
				myFormat.italic = true;
				deathText.setTextFormat(myFormat);
				deathText.autoSize = TextFieldAutoSize.CENTER
				deathText.x = (stage.stageWidth / 2) - (deathText.textWidth / 2);
				deathText.y = (stage.stageHeight / 2) - (deathText.textHeight / 2);
				gameTimer.stop();
				spawnTimer.stop();
			}
		
		}
		
		//Check if game has ended
		private function checkForEndOfGame():void
		{
			if (heroShip.getScore() > 9)
			{
				heroMovement.removeMovementHandlers(this.stage);
				var deathText:TextField = new TextField();
				stage.addChild(deathText);
				deathText.text = "You have won!";
				var myFormat:TextFormat = new TextFormat();
				myFormat.color = 0xAA0000;
				myFormat.size = 24;
				myFormat.italic = true;
				deathText.setTextFormat(myFormat);
				deathText.autoSize = TextFieldAutoSize.CENTER
				deathText.x = (stage.stageWidth / 2) - (deathText.textWidth / 2);
				deathText.y = (stage.stageHeight / 2) - (deathText.textHeight / 2);
				gameTimer.stop();
				spawnTimer.stop();
			}
		}
	}

}