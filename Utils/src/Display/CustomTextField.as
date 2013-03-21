package Display
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class CustomTextField
	{
		public function CustomTextField(){
		}
		
		public static function createTextField(_text:String, _x:Number, _y:Number, _textFormat:TextFormat, _useHtmlText:Boolean = false, _autoSize:String = TextFieldAutoSize.LEFT, _parent:Sprite = null):TextField{
			var tf:TextField = new TextField();
			
			tf.autoSize = _autoSize;
			tf.embedFonts = true;
			tf.defaultTextFormat = _textFormat;
			tf.selectable = false;
			tf.multiline = false;
			(_useHtmlText) ? tf.htmlText = _text : tf.text = _text;
			tf.x = _x;
			tf.y = _y;
			
			if(_parent !=null){
				_parent.addChild(tf);
			} 
			
			return tf;
		}
		
		public static function createMultiLineTextField(_text:String, _x:Number, _y:Number, _textFormat:TextFormat, _useHtmlText:Boolean = false, _autoSize:String = TextFieldAutoSize.LEFT, _parent:Sprite = null):TextField{
			var tf:TextField = new TextField();
			
			tf.autoSize = _autoSize;
			tf.embedFonts = true;
			tf.defaultTextFormat = _textFormat;
			tf.selectable = false;
			tf.multiline = true;
			(_useHtmlText) ? tf.htmlText = _text : tf.text = _text;
			tf.x = _x;
			tf.y = _y;
			
			if(_parent !=null){
				_parent.addChild(tf);
			} 
			
			return tf;
		}
	}
}