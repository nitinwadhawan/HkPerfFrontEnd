package hkperf;

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

	public String getDateTime() {
		return dateTime.replace(" ", ",").replace(":", ",").replace("-", ",").substring(0,19);
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
