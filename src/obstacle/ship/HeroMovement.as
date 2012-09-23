package obstacle.ship 
{
	import flash.display.Bitmap;
	import game.engine.DirectionNormalizer;
	import game.engine.CollisionDetector;
	
	/**
	 * 
	 * Handles all the movement for the hero's ship based on the ships speed
	 * Checks for collisions and reverses the movement if a collision occurs, then
	 * calls the normalizer to make sure the position is correct for the direction
	 * 
	 * "Maneuverability is the key to most battles, never underestimate it!"
	 * -Markar the Mighty
	 * 
	 * @author William Drescher
	 * 
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class HeroMovement
	{
		private var ship:HeroShip;
		public function HeroMovement(newShip:HeroShip) 
		{
			ship = newShip;
		}
		
		public function goUp(collisionDetector:CollisionDetector):void
		{
			ship.setDirection("up");
			ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
			DirectionNormalizer.normalize(ship);
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
		}
		
		public function goUpLeft(collisionDetector:CollisionDetector):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
			ship.setDirection("upLeft");
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			} else {
				DirectionNormalizer.normalize(ship);
			}
		}
		
		public function goUpRight(collisionDetector:CollisionDetector):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
			ship.setDirection("upRight");
			DirectionNormalizer.normalize(ship);
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
		}
		
		public function goDown(collisionDetector:CollisionDetector):void
		{
			ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
			ship.setDirection("down");
			DirectionNormalizer.normalize(ship);
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
		}
		
		public function goDownLeft(collisionDetector:CollisionDetector):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
			ship.setDirection("downLeft");
			DirectionNormalizer.normalize(ship);
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
		}
		
		public function goDownRight(collisionDetector:CollisionDetector):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
			ship.setDirection("downRight");
			DirectionNormalizer.normalize(ship);
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
		}
		
		public function goLeft(collisionDetector:CollisionDetector):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
			ship.setDirection("left");
			DirectionNormalizer.normalize(ship);
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
		}
		
		public function goRight(collisionDetector:CollisionDetector):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
			ship.setDirection("right");
			DirectionNormalizer.normalize(ship);
			if (collisionDetector.checkForShipCollisions(ship))
			{
				ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
		}
		
	}

}