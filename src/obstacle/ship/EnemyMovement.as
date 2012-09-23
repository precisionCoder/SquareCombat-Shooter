package obstacle.ship
{
	import flash.display.Bitmap;
	
	/**
	 * A class providing the AI for the enemy ships movement
	 * 
	 * "Krasmak's ships are run by simple machines, while this limits their intelligence their numbers are impressive"
	 * Markar the Mighty
	 * 
	 * @author William Drescher
	 * 
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class EnemyMovement
	{
		
		public function EnemyMovement(){}
		
		public function move(heroShip:HeroShip, enemyShip:EnemyShip):void
		{
			var enemyShipImage:Bitmap = enemyShip.getImage();
			if ((enemyShipImage.x - enemyShipImage.width / 2) < heroShip.getAbsoluteX())
			{
				enemyShip.getImage().x++;
			}
			if ((enemyShipImage.x + enemyShipImage.width / 2) > heroShip.getAbsoluteX())
			{
				enemyShip.getImage().x--;
			}
			if ((enemyShipImage.y + enemyShipImage.height / 2) < heroShip.getAbsoluteY())
			{
				enemyShip.getImage().y++;
			}
			if ((enemyShipImage.y - enemyShipImage.height / 2) > heroShip.getAbsoluteY())
			{
				enemyShip.getImage().y--;
			}
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