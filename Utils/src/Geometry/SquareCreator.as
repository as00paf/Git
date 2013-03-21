package Geometry
{
	import flash.display.Sprite;

	public class SquareCreator
	{
		public function SquareCreator()	{
		}
		
		public static function createSquare(_square:Sprite, _x:Number, _y:Number, _width:Number, _height:Number, _borderWidth:uint, _borderColor:uint, _fillColor:uint, _fillAlpha:Number, _borderAlpha:Number, _parent:Sprite=null):Sprite{
			_square.graphics.lineStyle(_borderWidth,_borderColor,_borderAlpha);
			_square.graphics.beginFill(_fillColor,_fillAlpha);
			_square.graphics.drawRect(0,0,_width,_height);
			_square.graphics.endFill();
			
			_square.x = _x;
			_square.y = _y;
			
			if(_parent!=null){
				_parent.addChild(_square);
			}
			
			return _square;
		}
		
		public static function editSquare(_square:Sprite, _width:Number, _height:Number, _borderWidth:uint, _borderColor:uint, _fillColor:uint, _fillAlpha:Number, _borderAlpha:Number):Sprite{
			_square.graphics.clear();
			_square.graphics.lineStyle(_borderWidth,_borderColor,_borderAlpha);
			_square.graphics.beginFill(_fillColor,_fillAlpha);
			_square.graphics.drawRect(0,0,_width,_height);
			_square.graphics.endFill();
			
			return _square;
		}
	}
}