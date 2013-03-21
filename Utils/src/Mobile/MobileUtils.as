package Mobile
{
	import flash.display.Stage;
	import flash.system.Capabilities;
	/**
	 * 
	 *
	 * @author Sps
	 * @version 1.0.1 [28 févr. 2012][Sps] creation
	 * @edited [10 janv. 2013][Afournier]
	 *
	 * utils.MobileUtils
	 */
	public class MobileUtils
	{
		static public var stage:Stage;
		static public const IOS:String = 'IOS';
		static public const ANDROID:String = 'ANDROID'
		static public const BLACKBERRY:String = 'BB';
		
		public function MobileUtils(s:Singleton)
		{
			throw "Tentative d'instanciation de la classe utils.MobileUtils dont l'API est statique.";
		}
		
		
		/**
		 * Seuil en ppi/dpi au dessus duquel le device est considéré comme 
		 * Tablette, et en deça comme phone.
		 * Attention, la diagonale calculée sera un peu inférieure à la 
		 * diagonale réelle si l'application n'est pas fullscreen (en 
		 * particulier vrai pour HoneyComb dont la barre système est très grosse)
		 * 
		 * La valeur par défaut de 6.5 est utile pour considérer les devices avec diagonale de 7 pouce sou plus comme tablettes, et moins comme phone
		 * 
		 * @see utils.MobileUtils#getScreenDiagonal() 
		 */
		static public var TABLET_DIAGONAL_THRESHOLD:Number = 6.5;
		
		static public const OS_DESKTOP:String 		= "DESKTOP";
		static public const OS_IOS:String 			= "IOS";
		static public const OS_BLACKBERRY:String 	= "BLACKBERRY";
		static public const OS_ANDROID:String 		= "ANDROID";
		
		static public const DEVICE_IPAD:String		= "IPAD";
		static public const DEVICE_IPHONE:String 	= "IPHONE";
		static public const DEVICE_IPHONE4:String 	= "IPHONE 4";
		static public const DEVICE_ANDROID_PHONE:String 	= "DEVICE_ANDROID_PHONE";
		static public const DEVICE_ANDROID_TABLET:String 	= "DEVICE_ANDROID_TABlET";
		static public const DEVICE_OTHER:String 	= "DEVICE_OTHER";
		
		/**
		 * 
		 * @return Une valeur parmis MobileUtils.OS_IOS, MobileUtils.OS_ANDROID ou MobileUtils.OS_BLACKBERRY
		 * 
		 */
		public static function get os():String
		{
			var playerVersion:String = Capabilities.version;
			// platform majorVersion,minorVersion,buildNumber,internalBuildNumber
			var platform:String = playerVersion.split(" ")[0];
			switch(platform)
			{
				case "AND":
					return OS_ANDROID;
					break;
				case "IOS":
					return OS_IOS;
					break;
				case "QNX":
					return OS_BLACKBERRY;
					break;
				
			}
			return OS_DESKTOP;
		}
		
		public static function get isMobile():Boolean
		{
			var playerVersion:String = Capabilities.version;
			// platform majorVersion,minorVersion,buildNumber,internalBuildNumber
			var platform:String = playerVersion.split(" ")[0];
			switch(platform)
			{
				case "AND":
				case "IOS":
				case "QNX":
					return true;
					break;
				
			}
			return false;
		}
		
		/** @private
		 * Mise en cache du résultat 
		 */
		private static var _isTablet:int = -1;
		/**
		 * Si besoin de modification précise du seuil de distinction tablet/phone,
		 * la valeur de MobileUtils.TABLET_DIAGONAL_THRESHOLD peut être modifiée  
		 * 
		 * @return 
		 */
		public static function get isTablet():Boolean
		{
			if (_isTablet < 0) {
				if (getScreenDiagonal() > TABLET_DIAGONAL_THRESHOLD) {
					_isTablet = 1;
				} else {
					_isTablet = 0;
				}
			}
			return (_isTablet > 0);
		}
		
		
		/**
		 * Attention, la diagonale calculée sera un peu inférieure à la diagonale réelle si l'application n'est pas fullscreen (en particulier vrai pour HoneyComb dont la barre système est très grosse) 
		 * @return 
		 * 
		 * @see utils.MobileUtils#TABLET_DIAGONAL_THRESHOLD
		 */
		public static function getScreenDiagonal():Number
		{
			// On récupère le nombre de DPI
			var dpi:Number = Capabilities.screenDPI;
			// On récupère la taille de l'écran en pixels
			var pxX:Number = Capabilities.screenResolutionX;
			var pxY:Number = Capabilities.screenResolutionY;
			
			
			if(stage) {	
				pxX = stage.fullScreenWidth;
				pxY = stage.fullScreenHeight;
			}else{
				throw "You need to set the stage first";
			}
			
			//	trace("pxX, pxY, dpi :"+[pxX, pxY, dpi]);
			
			// On calcule les borde de l'écran en pouces
			var piX:Number = pxX / dpi;
			var piY:Number = pxY / dpi;
			
			var diag2:Number = Math.pow(piX, 2) + Math.pow(piY, 2);
			var diag:Number = Math.sqrt(diag2);
			
			return diag;
		}
		
		
		
		/**
		 * Retourne le type de device mobiel parmis DEVICE_IPAD, DEVICE_IPHONE, DEVICE_IPHONE4, DEVICE_ANDROID_PHONE, DEVICE_ANDROID_TABLET, DEVICE_OTHER
		 * les iPod sont gérés comme les iPhone, en fonction de leur résolutions
		 * Pour distinguer les devices Android, l'appel à  getScreenDiagonal() est fait. 
		 * 
		 * @return  Une valeur parmi MobileUtils.DEVICE_IPAD, DEVICE_IPHONE, DEVICE_IPHONE4, DEVICE_ANDROID_PHONE, DEVICE_ANDROID_TABLET, DEVICE_OTHER
		 * 
		 */
		static public function getDeviceType():String
		{	
			// iPad		1, 2		768*1024	132 ppi
			
			// iPhone	1, 2 3, 3G 3GS
			// iPod		1, 2, 3 
			// iPhone 	3GS 		320*480		163 ppi
			
			// iPod		4
			// iPhone	4, 4S
			// iPhone 	4, 4S		640*960		326ppi
			
			var strOS:String = os;
			
			if (strOS == OS_IOS) 
			{
				var sizesDPI:Number = Capabilities.screenDPI;
				var sizes:Array = [Capabilities.screenResolutionX, Capabilities.screenResolutionY];
				sizes.sort(Array.NUMERIC);
				var sizesStr:String = sizes.join(" ");
				switch(sizes)
				{
					case "768 1024":
						return DEVICE_IPAD; //
						break;
					
					case "320 480":
						return DEVICE_IPHONE;
						break;
					
					case "640 960":
						return DEVICE_IPHONE4;
						break;
					
				}
			} else if (strOS == OS_ANDROID) {
				if (isTablet) {
					return DEVICE_ANDROID_TABLET;
				} else {
					return DEVICE_ANDROID_PHONE;
				}
			}
			return DEVICE_OTHER;
		}
	}
}

class Singleton {}
