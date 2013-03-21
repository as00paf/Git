package Display
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.plugins.TransformMatrixPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class DisplayObjectManager
	{
		public function DisplayObjectManager(){
		}
		
		public static function addObject(_object:DisplayObject, _x:Number, _y:Number, _parent:Sprite, _visible:Boolean = true):void{
			_object.x = _x;
			_object.y = _y;
			_object.visible = _visible;
			_parent.addChild(_object);
		}
		
		//Maybe add addObjectAt
		
		public static function removeObject(_object:DisplayObject, _parent:Sprite):void{
			if(_parent != null && _object !=null){
				if(_parent.contains(_object)){
					_parent.removeChild(_object);
				}
			}
		}
		
		public static function removeObjects(_objects:Array, _parent:Sprite):void{
			var _object:DisplayObject;
			for each(_object in _object){
				if(_parent != null && _object !=null){
					if(_parent.contains(_object)){
						_parent.removeChild(_object);
					}
				}
			}
		}
		
		public static function emptyContainer(_container:Sprite, keepLowest:Boolean = false):void{
			if(_container != null){
				while(_container.numChildren > (keepLowest) ? 1 : 0){
					_container.removeChildAt((keepLowest) ? 1 : 0);
				}
			}
		}
		
		//Hide/Show by fade
		public static function fadeToShow(_object:DisplayObject, _duration:Number=0.8, onCompleteFunction:Function=null):void{
			if(_object.visible == true && _object.alpha ==1){
				return;	
			}else{
				_object.alpha = 0;
				_object.visible = true;
				TweenLite.to(_object, _duration, {alpha:1, onComplete:onCompleteFunction});
			}
		}
		
		public static function fadeToHide(_object:DisplayObject, _duration:Number=0.8, onCompleteFunction:Function=null):void{
			TweenLite.to(_object, _duration, {alpha:0, onComplete:onCompleteFunction});
		}
		
		//Hide/Show by fade for many objects
		public static function fadeToShowArray(_objectsArray:Array, _duration:Number=0.8, onCompleteFunction:Function=null):void{
			var _object:DisplayObject;
			for each(_object in _objectsArray){
				if(_object.alpha==0 || _object.visible == false){
					_object.alpha = 0;
					_object.visible = true;
					TweenLite.to(_object, _duration, {alpha:1, onComplete:onCompleteFunction});
				}
			}
		}
		
		public static function fadeToHideArray(_objectsArray:Array, _duration:Number=0.8, onCompleteFunction:Function=null):void{
			var _object:DisplayObject;
			for each(_object in _objectsArray){
				TweenLite.to(_object, _duration, {alpha:0, onComplete:onCompleteFunction});
			}
		}
		
		//Shows screens that pop up
		public static function fadeAndScaleIn(_fadeMC:Sprite, _scaleMC:Sprite):void{
			_scaleMC.x = _scaleMC.width - (0.9*_scaleMC.width);
			_scaleMC.y = _scaleMC.height - (0.9*_scaleMC.height);
			_scaleMC.scaleX = _scaleMC.scaleY = 0.9;
			_scaleMC.alpha = 0;
			
			_fadeMC.alpha = 0;
			TweenLite.to(_fadeMC, 0.4, {alpha:1, onComplete:onFadeInComplete, onCompleteParams:[_scaleMC]});
		}
		
		private static function onFadeInComplete(_scaleMC:Sprite):void{
			TweenPlugin.activate([TransformMatrixPlugin]);
			var _x:Number = (960-_scaleMC.x);
			var _y:Number = (540-_scaleMC.y);
			
			var transformedVector:Point = new Point( _x*1.1, _y*1.1 );
			
			_x = 960-(transformedVector.x);
			_y = 540-(transformedVector.y);
			var _scale:Number = _scaleMC.scaleX*1.1;
			TweenLite.to(_scaleMC, 0.6, {alpha:1, ease:Back.easeInOut, transformMatrix:{x:_x, y:_y, scaleX:_scale, scaleY:_scale}});
		}
		
		//Hides screens that pop up
		public static function fadeAndScaleOut(_fadeMC:Sprite, _scaleMC:Sprite, _onCompleteFunction:Function):void{
			var _x:Number = (960-_scaleMC.x);
			var _y:Number = (540-_scaleMC.y);
			
			var transformedVector:Point = new Point( _x*0.9, _y*0.9 );
			
			_x = 960-(transformedVector.x);
			_y = 540-(transformedVector.y);
			var _scale:Number = 0.9;
			TweenLite.to(_scaleMC, 0.6, {alpha:0, ease:Back.easeInOut, transformMatrix:{x:_x, y:_y, scaleX:_scale, scaleY:_scale}, onComplete:onFadeOutComplete, onCompleteParams:[_fadeMC,_onCompleteFunction]});
		}
		
		private static function onFadeOutComplete(_fadeMC:Sprite, _onCompleteFunction:Function):void{
			TweenLite.to(_fadeMC, 0.4, {alpha:0, onComplete:_onCompleteFunction});
		}
	}
}