package Display
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class ButtonCreator
	{
		public function ButtonCreator(){
			
		}
		
		public static function createButton(_sprite:Sprite, _parent:Sprite, _text:String, _width:Number, _height:Number, _x:Number, _y:Number, _addToStage:Boolean=false, _clickFunction:Function=null):Sprite{
			//GFX
			if(_sprite==null){
				_sprite = new Sprite();
			}
			_sprite.graphics.lineStyle(0,0x000000);
			_sprite.graphics.beginFill(0x000000);
			_sprite.graphics.drawRect(0,0,_width,_height);
			_sprite.graphics.endFill();
			
			_sprite.x = _x;
			_sprite.y = _y;
			_sprite.buttonMode = true;
			_sprite.mouseChildren = false;
			
			var _tf:TextField = new TextField();
			_tf.name = "TextField";
			_tf.autoSize = TextFieldAutoSize.CENTER;
			_tf.text = _text;
			_tf.x = (_width-_tf.width)/2;
			_tf.y = 5;
			_tf.multiline = false;
			_tf.textColor = 0xFFFFFF;
			_sprite.addChild(_tf);
			
			if(_addToStage){
				_parent.addChild(_sprite);
			}
			
			if(_clickFunction!=null){
				_sprite.addEventListener(MouseEvent.CLICK, _clickFunction, false, 0, true);
			}
			
			return _sprite;
		}
	}
}