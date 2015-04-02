package kr.ac.kaist.hrhrp.image;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import org.springframework.stereotype.Service;

@Service("imageFilterBackgroundService")
public class ImageFilterBackgroundService {
	public ImageFilterBackgroundService() {
		System.out.println("IMAGEFILTER_TEST");
		Timer timer = new Timer(true);
		ImageFilterTask imageFilterTask = new ImageFilterTask();
		Calendar cal = Calendar.getInstance();
		int hour = cal.get(Calendar.HOUR_OF_DAY);
				
		if (4 < hour && hour <= 23) {
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE), 4, 0, 0);
		} else {
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE) + 1, 4, 0, 0);
		}
		//timer.scheduleAtFixedRate(imageFilterTask, 1000, 1000*60*3);
		timer.schedule(imageFilterTask, new Date(cal.getTimeInMillis()), 24*60*60*1000);
		System.out.println("IMAGEFILTER_TEST_START");
	}
}
