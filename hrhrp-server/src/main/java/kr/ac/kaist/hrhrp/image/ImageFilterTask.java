package kr.ac.kaist.hrhrp.image;

import java.text.DateFormat;
import java.util.Date;
import java.util.TimerTask;

import kr.ac.kaist.hrhrp.Extractor;
import kr.ac.kaist.hrhrp.ImageFilter;

public class ImageFilterTask extends TimerTask {

	@Override
	public void run() {
		// TODO Auto-generated method stub

		ImageFilter imageFilter = new ImageFilter();
		Extractor extractor = new Extractor();
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG);

		String formattedDate = dateFormat.format(date);

		System.out.println("IMAGEFILTER-TIMER :: " + formattedDate);

		try {
			System.out.println("START IMAGE FILTERING .. ");
			imageFilter.imageFilter();
			System.out.println("DONE IMAGE FILTERING .. ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			System.out.println("START EXTRACTING IMAGE INFO .. ");
			extractor.extractor();
			System.out.println("DONE EXTRACTING IMAGE INFO .. ");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
