package com.illuzor.engine3d.ui.screens {
	
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.objects.Mesh;
	import com.greensock.TweenLite;
	import com.illuzor.engine3d.notifications.NotificationManager;
	import com.illuzor.engine3d.tools.ModelRotator;
	import com.illuzor.engine3d.ui.Button;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	internal class Scene3d extends Sprite {
		
		private var rootContainer:Object3D;
		private var camera:Camera3D;
		private var stage3d:Stage3D;
		private var model:Mesh;
		private var buttonsContainer:Sprite;
		private var modelContainer:Object3D;
		
		public function Scene3d(mesh:Mesh) {
			model = mesh;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			rootContainer = new Object3D();
			NotificationManager.addWaitingMessage("calculating...");

			camera = new Camera3D(0.1, 10000);
			var view:View = new View(stage.stageWidth, stage.stageHeight);
			view.antiAlias = 16;
			camera.view = view;
			view.hideLogo();
			camera.rotationX = -120*Math.PI/180;
			camera.y = -200;
			camera.z = 100;
			
			camera.debug = true;
			
			addChild(camera.view);
			addChild(camera.diagram);
			rootContainer.addChild(camera);
			
			modelContainer = new Object3D();
			rootContainer.addChild(modelContainer);
			
			model.scaleX = model.scaleY = model.scaleZ = 10;
			modelContainer.addChild(model);
			ModelRotator.setParameters(modelContainer);

			stage3d = stage.stage3Ds[0];
			stage3d.addEventListener(Event.CONTEXT3D_CREATE, onContext3dCreated);
			stage3d.requestContext3D();
		}
		
		private function onContext3dCreated(e:Event):void {
			for each (var resource:Resource in rootContainer.getResources(true)) {
				resource.upload(stage3d.context3D);
			}
			NotificationManager.removeWaitingMessage();
			start();
		}
		
		private function start():void {
			addButtons();
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event):void {
			camera.render(stage3d);
		}
		
		private function addButtons():void {
			buttonsContainer = new Sprite();
			addChild(buttonsContainer);
			
			var resetRotationButton:Button = new Button("ResetRotation");
			buttonsContainer.addChild(resetRotationButton);
			
			buttonsContainer.x = stage.stageWidth - buttonsContainer.width - 10;
			buttonsContainer.y = stage.stageHeight - buttonsContainer.height - 10;
			
			resetRotationButton.addEventListener(MouseEvent.CLICK, resetRotation);
		}
		
		private function resetRotation(e:MouseEvent):void {
			TweenLite.to(modelContainer, 1, { rotationX:0, rotationY:0, rotationZ:0 } );
		}
	}
}