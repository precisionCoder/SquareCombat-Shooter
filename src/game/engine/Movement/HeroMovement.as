package game.engine.Movement
{
	import flash.display.Bitmap;
	import game.engine.Object.HeroShip;
	import game.engine.Screen.CollisionDetector;
	import game.engine.Screen.ScreenManager;
	
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
		private var screenManager:ScreenManager;
		private var collisionDetector:CollisionDetector;
		public function HeroMovement(ship:HeroShip, screenManager:ScreenManager)
		{
			this.ship = ship;
			this.screenManager = screenManager;
			collisionDetector = new CollisionDetector();
		}
		
		private function pathBlocked():Boolean
		{
			var pathBlocked:Boolean = false;
			if (collisionDetector.checkIfObjectIsOutOfBounds(ship.getAbsoluteX(), ship.getAbsoluteY(), ship.getImage(), ship.getParent()))
			{
				pathBlocked = true;
			}
			if (collisionDetector.checkForShipCollisions(ship, screenManager))
			{
				pathBlocked = true;
			}
			return pathBlocked;
		}
		
		private function fixCoords():void
		{
			if (ship.getAbsoluteX() < collisionDetector.getMinX(ship.getImage()))
			{
				ship.setAbsoluteX(collisionDetector.getMinX(ship.getImage()));
				trace("X was less than the min");
			}
			if (ship.getAbsoluteX() > collisionDetector.getMaxX(ship.getImage()))
			{
				ship.setAbsoluteX(collisionDetector.getMaxX(ship.getImage()));
				trace("X was more than the max");
			}
			if (ship.getAbsoluteY() < collisionDetector.getMinY(ship.getImage()))
			{
				ship.setAbsoluteY(collisionDetector.getMinY(ship.getImage()));
				trace("Y was less than the min");
			}
			if (ship.getAbsoluteY() > collisionDetector.getMaxY(ship.getImage()))
			{
				ship.setAbsoluteY(collisionDetector.getMaxY(ship.getImage()));
				trace("Y was more than the max");
			}
		}
		
		public function goUp(screenManager:ScreenManager):void
		{
			ship.setDirection("up");
			ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
		public function goUpLeft(screenManager:ScreenManager):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
			ship.setDirection("upLeft");
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
		public function goUpRight(screenManager:ScreenManager):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
			ship.setDirection("upRight");
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
		public function goDown(screenManager:ScreenManager):void
		{
			ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
			ship.setDirection("down");
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
		public function goDownLeft(screenManager:ScreenManager):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
			ship.setDirection("downLeft");
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
		public function goDownRight(screenManager:ScreenManager):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
			ship.setAbsoluteY(ship.getAbsoluteY() + ship.getSpeed());
			ship.setDirection("downRight");
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
				ship.setAbsoluteY(ship.getAbsoluteY() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
		public function goLeft(screenManager:ScreenManager):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
			ship.setDirection("left");
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
		public function goRight(screenManager:ScreenManager):void
		{
			ship.setAbsoluteX(ship.getAbsoluteX() + ship.getSpeed());
			ship.setDirection("right");
			DirectionNormalizer.normalize(ship);
			if (pathBlocked())
			{
				ship.setAbsoluteX(ship.getAbsoluteX() - ship.getSpeed());
				DirectionNormalizer.normalize(ship);
			}
			fixCoords();
		}
		
	}

}