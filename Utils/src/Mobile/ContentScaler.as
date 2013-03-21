package Mobile
{
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import Display.Objects.Size;
	
	[Event(name="ContentScalerEvent_initComplete", type="com.tribalnova.ios.dinotrain.event.ContentScalerEvent")]
	public class ContentScaler extends EventDispatcher
	{
		private static var _instance:ContentScaler;
		
		private var _deviceScreenSize:Size;
		private var _appSize:Size;
		private var _contentScaling:Number = NaN;
		
		private var _isInit:Boolean;
		
		private var _padderSize:Size;
		private var _scaledContentSize:Size;
		private var _centeredPosition:Point;
		
		public function ContentScaler(enforcer:SingletonEnforcer)
		{
			if(!enforcer)
				throw new Error("Singleton, cannot instantiate");
		}
		
		public static function get instance():ContentScaler
		{
			if(!_instance)
				_instance = new ContentScaler(new SingletonEnforcer());
			return _instance;
		}
		
		public static function set instance(value:ContentScaler):void
		{
			_instance = value;
		}
		
		public function get isInit():Boolean
		{
			return _isInit;
		}
		
		public function set isInit(value:Boolean):void
		{
			_isInit = value;
		}
		
		public function get deviceScreenSize():Size
		{
			return _deviceScreenSize;
		}
		
		public function set deviceScreenSize(value:Size):void
		{
			if(value != _deviceScreenSize)
			{
				_deviceScreenSize = value;
				_padderSize = null;
				_scaledContentSize = null;
				_contentScaling = NaN;
			}
		}
		
		public function get appSize():Size
		{
			return _appSize;
		}
		
		public function set appSize(value:Size):void
		{
			if(value != _appSize)
			{
				_appSize = value;
				_padderSize = null;
				_scaledContentSize = null;
				_contentScaling = NaN;
			}
		}
		
		public function get contentScalingFactor():Number
		{
			if(isNaN(_contentScaling))
			{
				if(deviceScreenSize && appSize)
					_contentScaling = deviceScreenSize.height / appSize.height;
				else
					_contentScaling = 1;
				_contentScaling = Number(_contentScaling.toFixed(16));
			}
			return _contentScaling;
		}
		
		public function get centeredPosition():Point
		{
			if(!_centeredPosition)
			{
				_centeredPosition = new Point(sidePadderVisibleSize.width,0);
			}
			return _centeredPosition;
		}
		
		public function get scaledContentSize():Size
		{
			return new Size(appSize.width * contentScalingFactor, appSize.height * contentScalingFactor);
		}
		
		public function get needsCustomScaling():Boolean
		{
			return contentScalingFactor % 1 != 0;
		}
		
		public function get sidePadderVisibleSize():Size
		{
			if(!_padderSize)
			{
				var padderWidth:Number = (deviceScreenSize.width - scaledContentSize.width) /2;
				padderWidth = Math.ceil(padderWidth);
				_padderSize = new Size(padderWidth, deviceScreenSize.height);
			}
			return _padderSize;
		}
		
		public function init(deviceScreenSize:Size,appSize:Size):void
		{
			this.appSize = appSize;
			this.deviceScreenSize = deviceScreenSize;
			initComplete();
		}
		
		protected function initComplete():void
		{
			_isInit = true;
			//dispatchEvent(new ContentScalerEvent(ContentScalerEvent.INIT_COMPLETE));
		}
		
		public function scaleAndCenter(displayObject:DisplayObject):DisplayObject
		{
			displayObject.scaleX = displayObject.scaleY = contentScalingFactor;
			
			var centeredPos:Point = centeredPosition;
			displayObject.x += centeredPos.x;
			displayObject.y += centeredPos.y;
			
			return displayObject;
		}
	}
}


class SingletonEnforcer
{
	
}

