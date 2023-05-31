import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public aspect Logger {
	
	public static String getTime() {
		DateTimeFormatter tformat = DateTimeFormatter.ofPattern("E MMM dd HH:mm:ss z yyyy");
		ZonedDateTime now = ZonedDateTime.now();
		return tformat.format(now);
	}
}
