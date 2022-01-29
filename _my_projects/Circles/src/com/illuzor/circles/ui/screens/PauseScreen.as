package com.illuzor.circles.ui.screens {
	
	import com.greensock.TweenLite;
	import com.illuzor.circles.constants.GameType;
	import com.illuzor.circles.constants.PauseType;
	import com.illuzor.circles.events.PauseEvent;
	import com.illuzor.circles.tools.Assets;
	import com.illuzor.circles.tools.PlayManager;
	import com.illuzor.circles.tools.StorageManager;
	import starling.display.Button;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class PauseScreen extends Sprite {
		
		private var color:uint;
		private var playButton:Button;
		private var menuButton:Button;
		private var restartButton:Button;
		private var type:String;
		private var currentScore:uint;
		private var gameType:String;
		private var buttonsContainer:Sprite;
		private var textContainer:Sprite;
		
		public function PauseScreen(type:String, color:uint = 0xFF0000, currentScore:uint = 0, gameType:String = "") {
			this.gameType = gameType;
			this.currentScore = currentScore;
			this.type = type;
			this.color = color;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			var shape:Shape = new Shape();
			addChild(shape);
			shape.graphics.beginFill(0xFFFFFF, .85);
			shape.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			shape.graphics.endFill();
			
			var stageWidth:uint = stage.stageWidth;
			var stageHeight:uint = stage.stageHeight;
			
			buttonsContainer = new Sprite();
			addChild(buttonsContainer);
			
			playButton = new Button(Assets.atlas.getTexture("play_button"));
			playButton.width = playButton.height = 200;
			buttonsContainer.addChild(playButton);
			
			menuButton = new Button(Assets.atlas.getTexture("menu_button"));
			menuButton.width = menuButton.height = 200;
			menuButton.x = 600;
			buttonsContainer.addChild(menuButton);
			
			restartButton = new Button(Assets.atlas.getTexture("replay_button"));
			restartButton.width = restartButton.height = 200;
			restartButton.x = 300;
			buttonsContainer.addChild(restartButton);
			
			playButton.color = color;
			menuButton.color = color;
			restartButton.color = color;
			
			if (type == PauseType.GAME_OVER) {
				buttonsContainer.removeChild(playButton);
				restartButton.x = 0;
				menuButton.x = 300;
				showScores();
			}
			
			if (buttonsContainer.width > stageWidth / 2) {
				buttonsContainer.width = stageWidth / 2;
				buttonsContainer.scaleY = buttonsContainer.scaleX;
			}
			
			buttonsContainer.x = (stageWidth - buttonsContainer.width) >> 1;
			
			if (type == PauseType.GAME_OVER) {
				buttonsContainer.y = textContainer.y + textContainer.height + buttonsContainer.height / 2;
			} else {
				buttonsContainer.y = (stageHeight - buttonsContainer.height) >> 1;
			}
			
			playButton.addEventListener(Event.TRIGGERED, onButton);
			menuButton.addEventListener(Event.TRIGGERED, onButton);
			restartButton.addEventListener(Event.TRIGGERED, onButton);
			
			this.alpha = 0;
			TweenLite.to(this, .3, { alpha:1 } );
		}
		
		private function showScores():void {
			var bestScore:uint;
			switch (gameType) {
				case GameType.TIME:
					bestScore = StorageManager.getInt("timeScores");
					if (bestScore < currentScore) {
						bestScore = currentScore;
						if (PlayManager.signedIn) PlayManager.submitScore(PlayManager.LEADERBOARD_SPEED, bestScore);
						StorageManager.setInt("timeScores", currentScore);
					}
				break;
				case GameType.SIZE:
					bestScore = StorageManager.getInt("sizeScores");
					if (bestScore < currentScore) {
						bestScore = currentScore
						if (PlayManager.signedIn) PlayManager.submitScore(PlayManager.LEADERBOARD_SIZE, bestScore);
						StorageManager.setInt("sizeScores", currentScore);
					}
				break;
				case GameType.COMPLETE:
					bestScore = StorageManager.getInt("completeScores");
					if (bestScore < currentScore) {
						bestScore = currentScore;
						if (PlayManager.signedIn) PlayManager.submitScore(PlayManager.LEADERBOARD_INSANE, bestScore);
						StorageManager.setInt("completeScores", currentScore);
					}
				break;
			}
			
			textContainer = new Sprite();
			addChild(textContainer);
			
			var currentScoreText:TextField = new TextField(10, 10, Assets.lang.texsts.currentScore + String(currentScore), "play", 100, color);
			textContainer.addChild(currentScoreText);
			currentScoreText.batchable = true;
			currentScoreText.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			
			var bestScoreText:TextField = new TextField(10, 10, Assets.lang.texsts.totalScore + String(bestScore), "play", 100, color);
			textContainer.addChild(bestScoreText);
			bestScoreText.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			bestScoreText.batchable = true;
			bestScoreText.y = currentScoreText.height * 2;
			
			if (textContainer.width > stage.stageWidth * .6) {
				textContainer.width = stage.stageWidth * .6;
				textContainer.scaleY = textContainer.scaleX;
			}
			
			textContainer.x = (stage.stageWidth - textContainer.width) >> 1;
			textContainer.y = (stage.stageHeight - textContainer.height) >> 1;
		}
		
		private function onButton(e:Event):void {
			playButton.removeEventListener(Event.TRIGGERED, onButton);
			menuButton.removeEventListener(Event.TRIGGERED, onButton);
			restartButton.removeEventListener(Event.TRIGGERED, onButton);
			switch (e.currentTarget) {
				case playButton:
					dispatchEvent(new PauseEvent(PauseEvent.PLAY));
				break;
				
				case menuButton:
					dispatchEvent(new PauseEvent(PauseEvent.MENU));
				break;
				
				case restartButton:
					dispatchEvent(new PauseEvent(PauseEvent.REPLAY));
				break;
			}
		}
		
	}
}