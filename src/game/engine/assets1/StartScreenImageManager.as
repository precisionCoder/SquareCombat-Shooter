package game.engine.assets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * Class for managing images for start screen
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class StartScreenImageManager
	{
		//Start Screen Images
		
		[Embed(source="../../images/StartButton.png")]
		private static var startButtonImage:Class;
		private static var startButtonImageBitmap:BitmapData;
		
		[Embed(source="../../images/Instructions.png")]
		private static var instructionsImage:Class;
		private static var instructionsImageBitmap:BitmapData;
		
		[Embed(source="../../images/StartScreenBackground.png")]
		private static var startScreenBackgroundImage:Class;
		private static var startScreenBackgroundImageBitmap:BitmapData;
		
		[Embed(source="../../images/Title.png")]
		private static var titleImage:Class;
		private static var titleImageBitmap:BitmapData;
		
		public static function init():void
		{
			startButtonImageBitmap = (new startButtonImage() as Bitmap).bitmapData;
			instructionsImageBitmap = (new instructionsImage() as Bitmap).bitmapData;
			startScreenBackgroundImageBitmap = (new startScreenBackgroundImage() as Bitmap).bitmapData;
			titleImageBitmap = (new titleImage as Bitmap).bitmapData;
		}
		
		public static function getStartButtonImage():BitmapData
		{
			return startButtonImageBitmap;
		}
		
		public static function getInstructionsImage():BitmapData
		{
			return instructionsImageBitmap;
		}
		
		public static function getStartScreenBackgroundImage():BitmapData
		{
			return startScreenBackgroundImageBitmap;
		}
		
		public static function getTitleImage():BitmapData
		{
			return titleImageBitmap;
		}
	
	}

}