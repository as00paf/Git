package Display{
	public class Color{
		public static function randomColor():Number{
			var color:Number = Math.random() * 0xffffff;
			return color;
		}
	}
}