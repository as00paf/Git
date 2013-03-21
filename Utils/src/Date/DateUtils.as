package Date{	
	public class DateUtils{
		
		//Returns -1 if the first date is before the second
		//Returns 0 if the dates are equal
		//Returns 1 if the first date is after the second
		
		public static function compare (date1 : Date, date2 : Date) : Number
		{
			var date1Timestamp : Number = date1.getTime ();
			var date2Timestamp : Number = date2.getTime ();
			
			var result : Number = -1;
			
			if (date1Timestamp == date2Timestamp)
			{
				result = 0;
			}
			else if (date1Timestamp > date2Timestamp)
			{
				result = 1;
			}
			
			return result;
		}
	}
}

