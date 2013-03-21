package Video{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class VideoStream{
		private static var _video:Video;
		private static var _nc:NetConnection;
		private static var _ns:NetStream;
		private static var _viewPort:DisplayObjectContainer;
		private static var _netStatusHandler:Function;
		
		private static var _videoURL:String;
		private static var _videoWidth:uint = 640;
		private static var _videoHeight:uint = 480;
		
		public static function setup(videoURL:String, viewPort:DisplayObjectContainer, videoWidth:int = 640, videoHeight:int = 480, netStatusHandlerFunction:Function = null):void{
			if(videoURL==""){
				throw new Error("The video's URL is null");
			}
			
			_videoURL = videoURL;
			_viewPort = viewPort;
			_videoWidth = videoWidth;
			_videoHeight = videoHeight;
			_netStatusHandler = (netStatusHandlerFunction != null) ? netStatusHandlerFunction : netStatusHandler;
		}
		
		public static function streamVideo(_url:String):void{
			_video = null;
			_video = new Video(_videoWidth, _videoHeight);
			_viewPort.addChild(_video);
			
			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_nc.connect(null);
			
			_ns = new NetStream(_nc);
			//ns.bufferTime = 1;
			_video.attachNetStream(_ns);
			
			var listener:Object = new Object();
			listener.onMetaData = function(evt:Object):void {};
			
			_ns.client = listener;
			_ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			_ns.play(_videoURL);
		}
		
		//Handler (example)
		private static function netStatusHandler(e:NetStatusEvent):void{
			switch(e.info.code){
				case "NetStream.Play.Start" : // Video starts
					
					break;
				case "NetStream.Play.Stop" : // Video is over
					
					break;
				case "NetStream.Buffer.Full" : // Video buffer completed
					
					break;
			}
		}		
	}
}