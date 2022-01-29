package com.illuzor.otherside.controllers.resource {
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class SQLiteHelper {
		
		private var connection:SQLConnection;
		
		public function SQLiteHelper() {
			var file:File = File.applicationDirectory.resolvePath("configs/levels/curves.db");
			connection = new SQLConnection();
			connection.open(file, SQLMode.READ);
		}
		
		public function selectCurve(curveId:String):Object {
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = connection;
			statement.text = 'SELECT value FROM curves WHERE id = "' + curveId + '"'; 
			statement.execute();
			var result:SQLResult = statement.getResult(); 
			return JSON.parse(result.data[0].value);
		}
		
		public function close():void {
			connection.close();
			connection = null;
		}
		
	}
}