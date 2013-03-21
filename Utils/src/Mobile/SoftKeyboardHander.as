package Mobile{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.text.TextField;

	public class SoftKeyboardHander{
		private static var _inputText:TextField;
		private static var _stage:Stage;
		private static var _viewPort:DisplayObjectContainer;
		
		public static function handleSoftKeyboard(inputText:TextField):void{
			_inputText = inputText;
			_stage = _inputText.stage;
			_viewPort = _inputText.parent;
			
			_inputText.addEventListener(FocusEvent.FOCUS_IN, onFocus, false, 0, true);
			
			if(MobileUtils.os == MobileUtils.OS_ANDROID && MobileUtils.isTablet){
				_stage.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onActivateSoftKeyboard);
				_stage.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, onDeactivateSoftKeyboard);
				_inputText.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut, false, 0, true);
			}
		}
		
		private static function onFocus(event:FocusEvent):void{
			_inputText.text = "";
		}
		
		private static function onFocusOut(event:FocusEvent):void{
			TweenLite.to(_viewPort, 0.3, {y:0});
		}
		
		private static function onActivateSoftKeyboard(event:SoftKeyboardEvent):void{
			TweenLite.to(_viewPort, 0.3, {y:-_stage.softKeyboardRect.height});
		}
		
		private static function onDeactivateSoftKeyboard(event:SoftKeyboardEvent):void{
		}
	}
}