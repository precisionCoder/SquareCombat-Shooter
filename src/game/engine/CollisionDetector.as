package game.engine
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import obstacle.bullet.Bullet;
	import obstacle.ship.EnemyShip;
	import obstacle.ship.HeroShip;
	import obstacle.ship.Ship;
	
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
		private var heroShip:HeroShip;
		private var obstacleArray:Array;
		
		public function CollisionDetector()
		{
			obstacleArray = new Array();
		}
		
		/**
		 * Check all of the objects for collisions with the hero's ship
		 * If a collision is found deal damage to both ships,
		 * if the enemy ship is destroyed remove it and add to the score of the hero
		 * will return true if the ship collides with either a ship or the edge of the 
		 * screen to prevent the ship from moving further in that direction
		 */
		public function checkForShipCollisions(newHeroShip:HeroShip):Boolean
		{
			heroShip = newHeroShip;
			var collisionCheck:Boolean = false;
			var arrayIndex:Number = 0;
			
			for each (var object:EnemyShip in obstacleArray)
			{
				if (heroShip.getImage().hitTestObject(object.getImage()))
				{
					collisionCheck = true;
					newHeroShip.takeDamage(10);
					object.takeDamage(10);
					if (object.getDead())
					{
						heroShip.addScore(1);
						obstacleArray.splice(arrayIndex, 1);
					}
				}
				arrayIndex++;
			}
			
			if (limitStageBorder(heroShip.getImage(), heroShip.getImage().x, heroShip.getImage().y))
			{
				collisionCheck = true;
			}
			
			return collisionCheck;
		}
		
		/**
		 * Check all of the enemy ships for collision with the bullet
		 * If an enemy ship is hit with a bullet damage the enemy ship
		 * and remove the bullet.  If the enemy is destroyed remove it from
		 * the list.
		 */
		public function checkForBulletCollisions(heroShip:HeroShip, heroBullet:Bitmap, damage:int):Boolean
		{
			var collisionCheck:Boolean = false;
			var arrayIndex:Number = 0;
			
			for each (var object:EnemyShip in obstacleArray)
			{
				if (heroBullet.hitTestObject(object.getImage()))
				{
					collisionCheck = true;
					object.takeDamage(damage);
					if (object.getDead())
					{
						heroShip.addScore(1);
						obstacleArray.splice(arrayIndex, 1);
					}
				}
				arrayIndex++;
			}
			
			return collisionCheck;
		}
		
		//Add a new enemy ship to the list of obstacles
		public function addToCollisionList(newShip:EnemyShip):void
		{
			obstacleArray.push(newShip);
		}
		
		//Checks whether the ship has left the screen
		public function limitStageBorder(image:Bitmap, x:int, y:int):Boolean
		{
			var outOfBounds:Boolean = false;
			
			//Checks if image is out of bounds on the x coordinate
			if (x > image.stage.stageWidth)
			{
				outOfBounds = true;
			}
			if (x < 0)
			{
				outOfBounds = true;
			}
			
			//Checks if image is out of bounds on the y coordinate 
			if (y > image.stage.stageHeight)
			{
				outOfBounds = true;
			}
			if (y < 0)
			{
				outOfBounds = true
			}
			
			return outOfBounds;
		}
	
		//Retrieve the list of enemy ships
		public function getObstacleArray():Array
		{
			return obstacleArray;
		}
		
		//Set a new list of enemy ships
		public function setObstacleArray(obstacleArray:Array):void
		{
			this.obstacleArray = obstacleArray;
		}
	}

}