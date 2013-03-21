package Audio
{
	import com.greensock.TweenLite;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	public class SoundObject{
		
		public const DEFAULT_BUFFER_TIME:Number = 0//3000;
		
		public var name:String;
		public var url:String;
		public var sound:Sound;
		public var channel:SoundChannel = new SoundChannel();
		public var paused:Boolean = true;
		public var loops:Number;
		public var volume:Number;
		public var position:Number;
		public var context:SoundLoaderContext;
		public var bufferTime:Number = DEFAULT_BUFFER_TIME;
		
		public function SoundObject(_name:String, _url:String, _volume:Number = 1, _position:Number = 0, _loops:Number = -1, _bufferTime:Number = DEFAULT_BUFFER_TIME){
			//Set instance values
			name = _name;
			volume = _volume;
			loops = _loops;
			position = position;
			bufferTime = _bufferTime;
			
			//Create sound
			sound = new Sound();
			var req:URLRequest = new URLRequest(_url);
			var context:SoundLoaderContext = new SoundLoaderContext(bufferTime);
			sound.load(req, context);
		}
		
		public function loop(_position:Number = 0, _volume:Number = 1, _loops:Number = -1):void{
			volume = _volume;
			position = _position;
			loops = _loops;
			
			if(paused){
				channel = sound.play(position, _loops, new SoundTransform(_volume));
			}else{
				channel = sound.play(_position, _loops, new SoundTransform(_volume));
			}
			
			paused = false;
		}
		
		public function playOnce(_position:Number = 0, _volume:Number = 1):void{
			volume = _volume;
			position = _position;
			loops = 1;
			
			if(paused){
				channel = sound.play(position, 1, new SoundTransform(_volume));
			}else{
				channel = sound.play(_position, 1, new SoundTransform(_volume));
			}
			
			paused = false;
		}
		
		public function stop():void{
			paused = true;
			channel.stop();
			position = channel.position;
		}
		
		public function pause():void{
			if(!paused){
				position = channel.position;
				channel.stop();	
			}else{
				channel = sound.play(position, loops, new SoundTransform(volume));
			}
			
			paused = !paused;
		}
		
		public function fadeSound(_targetVolume:Number = 0, _fadeLength:Number = 1):void{
			TweenLite.to(channel, _fadeLength, {volume: _targetVolume});
		}
		
		public function setVolume(_volume:Number):void{
			var soundTransform:SoundTransform = channel.soundTransform;
			soundTransform.volume = _volume;
			channel.soundTransform = soundTransform;
		}
		
		public function mute():void{
			setVolume(0);
		}
		
		public function unmute():void{
			setVolume(volume);
		}
	}
}