package Cursor
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class CursorManager
	{
		private static var cursor:DisplayObject;
		private static var stage:Stage;
		
		public function CursorManager(){
		}
		
		public static function useCursor(_cursor:DisplayObject, _stage:Stage):void{
			if(_stage == null){
				trace("_stage must not be null, cursor won't be applied");
				return;
			}
			stage = _stage;
			cursor = _cursor;
			_stage.addChild(_cursor);
			Mouse.hide();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, follow, false, 0, true);
			function follow(evt:MouseEvent):void{
				_cursor.x = stage.mouseX;
				_cursor.y = stage.mouseY;
			}
		}
		
		public static function useDefault():void{
			Mouse.show();
			if(stage != null && cursor != null){
				stage.removeChild(cursor);
				cursor = null;
			}			
		}
	}
}