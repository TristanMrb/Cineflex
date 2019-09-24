package oo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class DateFormatter {
    private static SimpleDateFormat frontendDate = new SimpleDateFormat("EEE, dd. MMM", new Locale("de", "DE"));
    private static SimpleDateFormat frontendTime = new SimpleDateFormat("HH:mm", new Locale("de", "DE"));
    // private static SimpleDateFormat timestamp = new SimpleDateFormat("dd MMM yyyy, HH:mm:ss", new Locale("de", "DE"));

    public static String getFrontendDate(Date date) {
        return frontendDate.format(date);
    }

    public static String getFrontendTime(Date date) {
        return frontendTime.format(date);
    }


}