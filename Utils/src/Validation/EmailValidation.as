package Validation{
	public class EmailValidation{
		private static const EMAIL_REGEX:RegExp = /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)+)@(([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)){2,}\.([A-Za-z]){2,4}+$/g;
		
		public static function validate(email:String):Boolean{
			return EMAIL_REGEX.test(email);			
		}
	}
}

