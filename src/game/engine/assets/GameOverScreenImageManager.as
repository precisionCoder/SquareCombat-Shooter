package game.engine.assets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * Class for managing images for game over screen
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class GameOverScreenImageManager
	{
		//Start Screen Images
		
		[Embed(source="../../images/GameOverBackground.png")]
		private static var gameOverBackgroundImage:Class;
		private static var gameOverBackgroundImageBitmap:BitmapData;
		
		[Embed(source="../../images/GameOverTitle.png")]
		private static var gameOverTitleImage:Class;
		private static var gameOverTitleImageBitmap:BitmapData;
		
		[Embed(source="../../images/FinalScorePanel.png")]
		private static var finalScorePanelImage:Class;
		private static var finalScorePanelImageBitmap:BitmapData;
		
		[Embed(source="../../images/ContinueButton.png")]
		private static var continueButtonImage:Class;
		private static var continueButtonImageBitmap:BitmapData;
		
		public static function init():void
		{
			gameOverBackgroundImageBitmap = (new gameOverBackgroundImage() as Bitmap).bitmapData;
			gameOverTitleImageBitmap = (new gameOverTitleImage() as Bitmap).bitmapData;
			finalScorePanelImageBitmap = (new finalScorePanelImage() as Bitmap).bitmapData;
			continueButtonImageBitmap = (new continueButtonImage as Bitmap).bitmapData;
		}
		
		public static function getGameOverBackgroundImage():BitmapData
		{
			return gameOverBackgroundImageBitmap;
		}
		
		public static function getGameOverTitleImage():BitmapData
		{
			return gameOverTitleImageBitmap;
		}
		
		public static function getFinalScorePanelImage():BitmapData
		{
			return finalScorePanelImageBitmap;
		}
		
		public static function getContinueButtonImage():BitmapData
		{
			return continueButtonImageBitmap;
		}
	
	}

}