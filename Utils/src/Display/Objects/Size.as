package Display.Objects
{
	public class Size
	{
		private var _width:Number;
		private var _height:Number;
		
		public function Size(width:Number=0,height:Number=0)
		{
			this.width = width;
			this.height = height;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		public function toString():String{
			return "Size("+width+", "+height+")";
		}
	}
}