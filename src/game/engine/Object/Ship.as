package game.engine.Object
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
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
	public class Ship extends GameObject
	{
		protected var health:int;
		protected var speed:uint;
		protected var dead:Boolean;
		protected var absoluteX:uint;
		protected var absoluteY:uint;
		protected var direction:String;
		
		public function Ship(image:Bitmap, health:uint, speed:uint, parent:Sprite)
		{
			super(image, parent);
			this.health = health;
			this.speed = speed;
			dead = false;
		}
		
		//Ship takes damage, triggers death if hp drop to 0 or less
		public function takeDamage(damage:int):void
		{
			health -= damage;
			if (health <= 0)
			{
				health = 0;
				setDead(true);
			}
		}
		
		//Accessors and mutators
		
		
		
		//Health
		public function getHealth():uint
		{
			return health;
		}
		
		public function setHealth(health:uint):void
		{
			this.health = health;
		}
		
		//Speed
		public function getSpeed():uint
		{
			return speed;
		}
		
		public function setSpeed(speed:uint):void
		{
			this.speed = speed;
		}
		
		//Dead
		public function getDead():Boolean
		{
			return dead;
		}
		
		public function setDead(dead:Boolean):void
		{
			this.dead = dead;
		}
		
		//Direction
		public function getDirection():String
		{
			return direction;
		}
		
		public function setDirection(direction:String):void
		{
			this.direction = direction;
		}
		
		//AbsoluteX
		public function setAbsoluteX(absoluteX:uint):void
		{
			this.absoluteX = absoluteX;
		}
		
		public function getAbsoluteX():uint
		{
			return absoluteX;
		}
		
		//AbsoluteY
		public function setAbsoluteY(absoluteY:uint):void
		{
			this.absoluteY = absoluteY;
		}
		
		public function getAbsoluteY():uint
		{
			return absoluteY
		}
		
	}

}