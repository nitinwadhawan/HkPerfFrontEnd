package hkperf;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * Created with IntelliJ IDEA.
 * User: Nitin Wadhawan
 * Date: 8/12/13
 * Time: 12:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class LoadParam {

	private float loadTime;
	private String dateTime;

	public String getDateTime()throws ParseException {
		dateTime= dateTime.replace(" ", ",").replace(":", ",").replace("-", ",").substring(0,19);
		/*Date date = new SimpleDateFormat("yyyy MM, dd,HH,mm,ss", Locale.ENGLISH).parse(dateTime);
		System.out.println(date); // Sat Jan 02 00:00:00 BOT 2010
		System.out.println("get date time :" +dateTime);*/
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	public float getLoadTime() {
		return loadTime;
	}

	public void setLoadTime(float loadTime) {
		this.loadTime = loadTime;
	}

}
