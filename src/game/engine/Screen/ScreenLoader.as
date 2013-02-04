package game.engine.screen
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Graphics;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import game.engine.main.ShooterGameManager;
	import game.engine.object.HeroShip;
	import game.engine.assets.StartScreenImageManager;
	import game.engine.assets.GameScreenImageManager;
	import game.engine.assets.GameOverScreenImageManager;
	
	/**
	 * A class that handles loading the various screens and bars that make up the ui
	 *
	 * @author William Drescher
	 *
	 * Copyright (c) 2012-2013 William Drescher
	 * Licensed under the MIT License, a copy of this license should be included with this software
	 * All artistic content of this game including images and sounds have all rights reserved
	 */
	public class ScreenLoader
	{
		private var titleImage:Bitmap;
		private var instructionsImage:Bitmap;
		private var startButtonImage:Bitmap;
		private var stage:Stage;
		private var startButton:Sprite;
		private var continueButton:Sprite;
		
		private var gameManager:ShooterGameManager;
		
		public function ScreenLoader(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function loadGameScreen():Sprite
		{
			var gameAreaImage:Bitmap = new Bitmap(GameScreenImageManager.getGameAreaImage());
			var gameArea:Sprite = new Sprite();
			var gameAreaFrameSize:int = 26;
			gameArea.addChild(gameAreaImage);
			gameArea.x = gameAreaFrameSize;
			gameArea.y = (stage.stageHeight - gameArea.height - gameAreaFrameSize);
			return gameArea;
		}
		
		public function loadGameFrame():Sprite
		{
			var gameFrameImage:Bitmap = new Bitmap(GameScreenImageManager.getGameFrameImage());
			var gameFrame:Sprite = new Sprite();
			gameFrame.x = 0;
			gameFrame.y = (stage.stageHeight - gameFrameImage.height);
			gameFrame.addChild(gameFrameImage);
			return gameFrame;
		}
		
		public function loadTopBar():Sprite
		{
			var topBarImage:Bitmap = new Bitmap(GameScreenImageManager.getTopBarImage());
			var topBar:Sprite = new Sprite();
			topBar.addChild(topBarImage);
			topBar.x = 0;
			topBar.y = 0;
			return topBar;
		}
		
		public function loadScreen():Sprite
		{
			var screenArea:Sprite = new Sprite();
			screenArea.graphics.beginFill(0x585858);
			screenArea.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			screenArea.graphics.endFill();
			screenArea.x = 0;
			screenArea.y = 0;
			return screenArea;
		}
		
		public function loadHealthBar():Sprite
		{
			var healthBarImage:Bitmap = new Bitmap(GameScreenImageManager.getHealthBarImage());
			var topBarImage:Bitmap = new Bitmap(GameScreenImageManager.getTopBarImage());
			var healthBar:Sprite = new Sprite();
			healthBar.addChild(healthBarImage);
			healthBar.x = (topBarImage.height - healthBar.height) / 2;
			healthBar.y = (topBarImage.height - healthBar.height) / 2;
			return healthBar;
		}
		
		public function loadScoreBar():Sprite
		{
			var scoreBarImage:Bitmap = new Bitmap(GameScreenImageManager.getScoreBarImage());
			var topBarImage:Bitmap = new Bitmap(GameScreenImageManager.getTopBarImage());
			var scoreBar:Sprite = new Sprite();
			scoreBar.addChild(scoreBarImage);
			scoreBar.x = (topBarImage.width - scoreBar.width) - ((topBarImage.height - scoreBar.height) / 2);
			scoreBar.y = (topBarImage.height - scoreBar.height) / 2;
			return scoreBar;
		}
		
		public function loadScoreBarText():TextField
		{
			//Add end game message
			var topBarImage:Bitmap = new Bitmap(GameScreenImageManager.getTopBarImage());
			var scoreBarImage:Bitmap = new Bitmap(GameScreenImageManager.getScoreBarImage());
			var score:TextField = new TextField();
			score.text = "0";
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 24;
			score.defaultTextFormat = myFormat;
			score.setTextFormat(myFormat);
			score.x = topBarImage.width - (scoreBarImage.width / 2);
			score.y = (topBarImage.height / 2) - 15;
			return score;
		}
		
		public function loadStartScreen(gameManager:ShooterGameManager):Sprite
		{
			this.gameManager = gameManager;
			//Create Screen
			var startScreen:Sprite = new Sprite();
			startScreen.addChild(new Bitmap(StartScreenImageManager.getStartScreenBackgroundImage()));
			var whitespace:int = 10;
			
			titleImage = new Bitmap(StartScreenImageManager.getTitleImage());
			titleImage.x = (startScreen.width / 2) - (titleImage.width / 2);
			titleImage.y = whitespace;
			startScreen.addChild(titleImage);
			
			//Add instructions
			instructionsImage = new Bitmap(StartScreenImageManager.getInstructionsImage());
			instructionsImage.x = (startScreen.width / 2) - (instructionsImage.width / 2);
			instructionsImage.y = titleImage.height + (whitespace * 2);
			startScreen.addChild(instructionsImage);
			
			//Add start button
			startButtonImage = new Bitmap(StartScreenImageManager.getStartButtonImage());
			startButton = new Sprite();
			startButton.addEventListener(MouseEvent.CLICK, startButtonClicked);
			startButton.x = (startScreen.width / 2) - (startButtonImage.width / 2);
			startButton.y = instructionsImage.height + (whitespace * 2) + ((instructionsImage.height + (whitespace * 2)) / 3);
			startButtonImage.alpha = 100;
			startButton.addChild(startButtonImage);
			startScreen.addChild(startButton);
			
			return startScreen;
		}
		
		private function startButtonClicked(event:MouseEvent):void
		{
			gameManager.startGame(1000);
		}
		
		public function loadGameOverScreen(gameManager:ShooterGameManager, heroShip:HeroShip):Sprite
		{
			var gameOverBackgroundImage:Bitmap = new Bitmap(GameOverScreenImageManager.getGameOverBackgroundImage());
			var gameOverTitleImage:Bitmap = new Bitmap(GameOverScreenImageManager.getGameOverTitleImage());
			var finalScoreImage:Bitmap = new Bitmap(GameOverScreenImageManager.getFinalScorePanelImage());
			
			var spacing:int = (gameOverBackgroundImage.height - gameOverTitleImage.height - finalScoreImage.height) / 3;
			this.gameManager = gameManager;
			
			var gameOverScreen:Sprite = new Sprite();
			gameOverBackgroundImage.x = 0;
			gameOverBackgroundImage.y = 0;
			gameOverScreen.addChild(gameOverBackgroundImage);
			
			gameOverTitleImage.x = (gameOverBackgroundImage.width / 2) - (gameOverTitleImage.width / 2);
			gameOverTitleImage.y = spacing;
			gameOverScreen.addChild(gameOverTitleImage);
			
			finalScoreImage.x = (gameOverBackgroundImage.width / 2) - (finalScoreImage.width / 2);
			finalScoreImage.y = gameOverTitleImage.height + (spacing * 2);
			gameOverScreen.addChild(finalScoreImage);
			
			//Add end game message
			var finalScore:TextField = new TextField();
			finalScore.text = heroShip.getScore().toString();
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 45;
			finalScore.setTextFormat(myFormat);
			finalScore.x = (gameOverScreen.width / 2) - (finalScore.textWidth / 2);
			finalScore.y = finalScoreImage.y + (finalScoreImage.height / 2) - (finalScore.height / 2);
			gameOverScreen.addChild(finalScore);
			
			//Add start button
			var continueButtonImage:Bitmap = new Bitmap(GameOverScreenImageManager.getContinueButtonImage());
			continueButton = new Sprite();
			continueButton.addEventListener(MouseEvent.CLICK, restartButtonClicked);
			continueButton.x = (gameOverScreen.width / 2) - (continueButtonImage.width / 2);
			continueButton.y = gameOverScreen.height - 100;
			continueButtonImage.alpha = 1;
			continueButton.addChild(continueButtonImage);
			gameOverScreen.addChild(continueButton);
			
			return gameOverScreen;
		}
		
		private function restartButtonClicked(event:MouseEvent):void
		{
			gameManager.startGame(1000);
		}
	}
}