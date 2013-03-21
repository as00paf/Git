package Debug
{
	import flash.events.Event;
	
	public class DebugEvent extends Event
	{
		public static const DEBUG_TEXT:String = "DebugText";
		public var text:String;
		
		public function DebugEvent(type:String, _text:String="")
		{
			super(type, bubbles, cancelable);
			text = _text;
		}
	}
}