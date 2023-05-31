import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import com.bettinghouse.User;;

public aspect Logger {
	

	
	//Iniciar sesion
	public static void writeToFile(String filename, String data) {
		if (Logger.createFile(filename)) {
			try {
				FileWriter archivo = new FileWriter(filename + ".txt", true);
				archivo.write(data);
				archivo.close();
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static String getTime() {
		DateTimeFormatter tformat = DateTimeFormatter.ofPattern("E MMM dd HH:mm:ss z yyyy");
		ZonedDateTime now = ZonedDateTime.now();
		return tformat.format(now);
	}
	
	pointcut logActivity(User u): 
		call(void com.bettinghouse.BettingHouse.effectiveLog*(User) ) &&
		args(u);
	
	after(User u):  logActivity(u){
		String s;
		if("call(void com.bettinghouse.BettingHouse.effectiveLogOut(User))".compareTo(thisJoinPointStaticPart.toString()) == 1) {
			s = "Sesion cerrada por usuario: [" + u.getNickname() + "]\tFecha: [" + Logger.getTime() + "]" + thisJoinPointStaticPart +"\n";
			
		}else if("call(void com.bettinghouse.BettingHouse.effectiveLogIn(User))".compareTo(thisJoinPointStaticPart.toString()) == 1) {
			s = "Sesion abierta por usuario: [" + u.getNickname() + "]\tFecha: [" + Logger.getTime() + "]" + thisJoinPointStaticPart +"\n";
		}
		
	}

}
