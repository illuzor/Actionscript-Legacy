package com.illuzor.engine3d.tools {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Parser {
		
		static public function parseXML(xml:XML):Object {
			var object:Object = new Object();
			object.settings = [];
			
			var models:Array = [];
			
			var modelList:XMLList = new XMLList();
			modelList = xml.models.model
	
			for (var i:int = 0; i < modelList.length(); i++) {
				var pointsList:Array = [];
				var elementsList:Array = [];
				
				if (modelList[i].@points == "true") pointsList = parsePoints(modelList[i].points.point);
				if (modelList[i].@elemets == "true") elementsList = parseElements(modelList[i].elements.element);
				
				models.push( { name:modelList[i].@modelName, modelPath:modelList[i].@modelPath, texturePath:modelList[i].@modelTexturePath, 
				points:modelList[i].@points, elemets:modelList[i].@elemets, type:modelList[i].@modelType, pointsList:pointsList, elementsList:elementsList} );
			}
			object.models = models;
			return object;
			// {}
		}
		
		static private function parsePoints(xml:XMLList):Array {
			var points:Array = [];
			for (var i:int = 0; i < xml.length(); i++) {
				points.push( { x:xml[i].@x, y:xml[i].@y, z:xml[i].@z, name:xml[i].@name, text:xml[i] } );
			}
			return points;
		}
		
		static private function parseElements(xml:XMLList):Array {
			var elements:Array = [];
			for (var i:int = 0; i < xml.length(); i++) {
				elements.push( { name:xml[i].@name, text:xml[i] } );
			}
			return elements;
		}
		
	}
}