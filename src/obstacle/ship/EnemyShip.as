package obstacle.ship
{
	import flash.display.Bitmap;
	import flash.display.Stage;
	/**
	 * Enemy ship class provides all the functionality for enemy ships,
	 * it can add and remove itself from the stage as well as take damage
	 * 
	 * "Blue as justice my ships ride forth as emissaries of my great empire"
	 * -Krasmak the Cruel
	 * 
	 * @author William Drescher
	 * 
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class EnemyShip extends Ship
	{		
		public function EnemyShip(newImage:Bitmap, newHealth:uint, newSpeed:uint, newStage:Stage) 
		{
			super(newImage, newHealth, newSpeed, newStage);
		}
		
		//Adds the ship to the screen
		public function addToStage(newX:int, newY:int):void
		{
			image.y = newY;
			image.x = newX;
			var newShip:Bitmap = new Bitmap( imageData );
			stage.addChild(image);
		}
		
		//Removes the ship from the screen
		public function removeFromStage():void
		{
			stage.removeChild(image);
		}
		
		//The ship takes damage and if it's health drops to 0 or below it is removed from the screen
		override public function takeDamage(newDamage:int):void
		{
			health -= newDamage;
			if (health <= 0)
			{
				setDead(true);
				removeFromStage();
			}
		}
	}

}