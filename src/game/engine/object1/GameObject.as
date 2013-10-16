package game.engine.object
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * Superclass for all objects that will have the option to be on the screen during the game.
	 * This would be an abstract class if AS3 allowed them
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class GameObject
	{
		private var image:Bitmap;
		private var parent:Sprite;
		
		//All game objects should require an image and a parent object that they will exist in
		public function GameObject(image:Bitmap, parent:Sprite)
		{
			this.image = image;
			this.parent = parent;
		}
		
		public function addToScreen(x:int, y:int):void
		{
			parent.addChild(image);
			image.x = x;
			image.y = y;
		}
		
		public function removeFromScreen():void
		{
			parent.removeChild(image);
		}
		
		//Accessors for image
		public function getImage():Bitmap
		{
			return image;
		}
		
		public function setImage(image:Bitmap):void
		{
			this.image = image;
		}
		
		public function getParent():Sprite
		{
			return parent;
		}
		
		public function setParent(parent:Sprite):void
		{
			this.parent = parent;
		}
	
	}

}