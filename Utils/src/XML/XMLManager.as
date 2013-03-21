package XML
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLManager extends EventDispatcher{
		
		private static var _instance:XMLManager = new XMLManager();
		private static var _loader:URLLoader = new URLLoader();
		private static var _dataLoaded:Boolean = false;
		private var _request:URLRequest = new URLRequest(URL+".xml");
		
		public static var URL:String;
		public var data:XMLList = new XMLList();
		
		public function XMLManager(){
			if(instance){
				throw new Error ("We cannot create a new instance.Please use Singleton.getInstance()");
			}
		}
		
		public function loadXML():void{
			if(URL==""){
				throw new Error ("URL must be set first");
			}
			_loader.addEventListener(Event.COMPLETE, onXmlLoaded, false, 0, true);
			_loader.load(_request);
		}
		
		//Handlers
		private function onXmlLoaded(e:Event):void{
			data = new XMLList(e.target.data);
			_dataLoaded = true;
			
			if(_dataLoaded){
				instance.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		//Singleton
		public static function get instance():XMLManager{
			return _instance;
		}
	}
}