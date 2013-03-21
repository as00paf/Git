package Audio{
	public class AudioStream{
		import flash.media.Sound;
		import flash.media.SoundLoaderContext;
		import flash.net.URLRequest;
		
		public static function StreamSound(url:String, bufferTime:int = 8000, checkPolicyFile:Boolean = true):void{
			var s:Sound = new Sound();
			var req:URLRequest = new URLRequest(url);
			var context:SoundLoaderContext = new SoundLoaderContext(bufferTime, checkPolicyFile);
			s.load(req, context);
			s.play();
		}		
	}
}
