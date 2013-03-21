package Audio
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class AudioManager extends EventDispatcher {
		
		private static var _instance:AudioManager = new AudioManager();
		
		public static const SOUND_PATH:String = "http://localhost/SiropCool/bin-debug/Audio/";
		
		private var soundPathArray:Array = ["bg_sound.mp3"]; 
		private var soundArray:Array = [];
		
		public function AudioManager(){
			if(instance){
				throw new Error ("We cannot create a new instance.Please use Singleton.getInstance()");
			}
		}
		
		public function loadSounds():void{
			var url:String;
			for each(url in soundPathArray){
				var soundObject:SoundObject = new SoundObject(url, SOUND_PATH+url);
				soundArray.push(soundObject);
			}
			dispatchEvent(new Event(Event.COMPLETE, true));
		}
		
		//Methods
		public function playBackgroundMusic():void{
			SoundObject(soundArray[0]).loop();
		}
		
		//Getters
		public function getSoundByName(_name:String):SoundObject{
			var so:SoundObject;
			var soundToReturn:SoundObject;
			for each(so in instance.soundArray){
				if(so.name == _name){
					soundToReturn = so;
				}
			}
			return soundToReturn;
		}
		
		//Singleton
		public static function get instance():AudioManager{
			return _instance;
		}
	}
}