package game.engine.Screen
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import game.engine.Object.Bullet;
	import game.engine.Object.EnemyShip;
	import game.engine.Object.GameObject;
	import game.engine.Object.HeroShip;
	import game.engine.Object.Ship;
	
	/**
	 * This class contains an array of all of the obstacles currently on the screen
	 * This currently includes just the enemy ships and the player's ship, but may
	 * expand as more objects are added to the game.
	 *
	 * "If it wasn't for obstacles we could do anything, go anywhere!"
	 * Markar the Mighty
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class CollisionDetector
	{
		public function CollisionDetector()
		{
			//Empty
		}
		
		/**
		 * Check all of the enemy ships for collisions with the hero's ship
		 * will return true if the heroShip collides with a ship
		 */
		public function checkForShipCollisions(heroShip:HeroShip, screenManager:ScreenManager):Boolean
		{
			var collisionCheck:Boolean = false;
			var enemyShipArray:Array = screenManager.getEnemyShipArray();
			var shipsCollidedWith:Array = new Array();
			
			for each (var enemyShip:EnemyShip in enemyShipArray)
			{
				if (heroShip.getImage().hitTestObject(enemyShip.getImage()))
				{
					collisionCheck = true;
					shipsCollidedWith.push(enemyShip);
				}
			}
			
			var shipManager:ShipManager = new ShipManager();
			shipManager.handleShipCollision(heroShip, shipsCollidedWith, screenManager);
			
			return collisionCheck;
		}
		
		/**
		 * Checks if the ship has left the bounds of the screen
		 */
		public function checkIfObjectIsOutOfBounds(x:int, y:int, image:Bitmap, gameArea:Sprite):Boolean
		{
			var outOfBounds:Boolean = false;
			
			//Checks if image is out of bounds on the x coordinate
			if (x > (image.stage.stageWidth - (image.width / 2)))
			{
				outOfBounds = true;
			}
			if (x < (image.width / 2))
			{
				outOfBounds = true;
			}
			
			//Checks if image is out of bounds on the y coordinate
			if (y > (image.stage.stageHeight - 40 - (image.width / 2)))
			{
				outOfBounds = true;
			}
			if (y < (image.height / 2))
			{
				outOfBounds = true
			}
			
			return outOfBounds;
		}
		
		public function getMinX(image:Bitmap):int
		{
			return (image.width / 2);
		}
		
		public function getMinY(image:Bitmap):int
		{
			return (image.height / 2);
		}
		
		public function getMaxX(image:Bitmap):int
		{
			return (image.stage.stageWidth - (image.width / 2));
		}
		
		public function getMaxY(image:Bitmap):int
		{
			return (image.stage.stageHeight - 40 - (image.width / 2));
		}
		
		/**
		 * Check all of the enemy ships for collision with the bullet
		 * If an enemy ship is hit call the ship manager bullet handling.
		 */
		public function checkForBulletCollisions(heroShip:HeroShip, bullet:Bullet, screenManager:ScreenManager):Boolean
		{
			var enemyShipArray:Array = screenManager.getEnemyShipArray();
			var collisionOccurred:Boolean = false;
			
			for each (var enemyShip:EnemyShip in enemyShipArray)
			{
				if (bullet.getImage().hitTestObject(enemyShip.getImage()))
				{
					{
						var shipManager:ShipManager = new ShipManager();
						shipManager.handleBulletCollision(heroShip, bullet, enemyShip, screenManager);
						collisionOccurred = true;
					}
				}
			}
			return collisionOccurred;
		}
		
		public function checkForCollisions(heroShip:HeroShip, enemyShip:EnemyShip):Boolean
		{
			var collisionCheck:Boolean = false;
			
			//loop through the objects in the array and check for collisions
			if (heroShip.getImage().hitTestObject(enemyShip.getImage()))
			{
				collisionCheck = true;
			}
			
			return collisionCheck;
		}
	
	}

}