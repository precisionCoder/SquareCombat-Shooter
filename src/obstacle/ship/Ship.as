package obstacle.ship
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	
	/**
	 * The ship class is a superclass inherited by both enemy and hero ships,
	 * it provides all the basic information and functionality that ships require
	 *
	 * "A ship is power, power is good, let's make ourselves the most powerful men in the galaxy!"
	 * -Krasmak the Cruel
	 *
	 * @author William Drescher
	 * 
	 * Copyright (c) 2012 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 */
	public class Ship
	{
		protected var health:int;
		protected var speed:uint;
		protected var dead:Boolean;
		protected var image:Bitmap;
		protected var imageData:BitmapData;
		protected var stage:Stage;
		protected var absoluteX:uint;
		protected var absoluteY:uint;
		protected var direction:String;
		
		public function Ship(newImage:Bitmap, newHealth:uint, newSpeed:uint, newStage:Stage)
		{
			image = newImage;
			imageData = newImage.bitmapData;
			health = newHealth;
			speed = newSpeed;
			dead = false;
			stage = newStage;
		}
		
		//Ship takes damage, triggers death if hp drop to 0 or less
		public function takeDamage(newDamage:int):void
		{
			health -= newDamage;
			if (health <= 0)
			{
				setDead(true);
			}
		}
		
		//Accessors and mutators
		
		//Image
		public function getImage():Bitmap
		{
			return image;
		}
		
		public function setImage(newImage:Bitmap):void
		{
			image = newImage;
		}
		
		//Health
		public function getHealth():uint
		{
			return health;
		}
		
		public function setHealth(newHealth:uint):void
		{
			health = newHealth;
		}
		
		//Speed
		public function getSpeed():uint
		{
			return speed;
		}
		
		public function setSpeed(newSpeed:uint):void
		{
			speed = newSpeed;
		}
		
		//Dead
		public function getDead():Boolean
		{
			return dead;
		}
		
		public function setDead(newDead:Boolean):void
		{
			dead = newDead;
		}
		
		//Direction
		public function getDirection():String
		{
			return direction;
		}
		
		public function setDirection(newDirection:String):void
		{
			direction = newDirection;
		}
		
		//Stage
		public function setStage(newStage:Stage):void
		{
			stage = newStage;
		}
		
		//AbsoluteX
		public function setAbsoluteX(newAbsoluteX:uint):void
		{
			absoluteX = newAbsoluteX;
		}
		
		public function getAbsoluteX():uint
		{
			return absoluteX;
		}
		
		//AbsoluteY
		public function setAbsoluteY(newAbsoluteY:uint):void
		{
			absoluteY = newAbsoluteY;
		}
		
		public function getAbsoluteY():uint
		{
			return absoluteY
		}
	}

}