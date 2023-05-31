import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import com.bettinghouse.User;;

public aspect Logger {
	
	public static Boolean createFile(String filename) {
		File arch = new File(filename + ".txt");
		try {
			arch.createNewFile();
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}
	
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
	
	pointcut signup(User u, Person p):
		call(void com.bettinghouse.BettingHouse.successfulSignUp(User, Person))
		&& args(u,p);
	
	after(User u, Person p): signup(u,p){
		String s = "Usuario registrado: [" + u.toString() + "] Fecha: [" +  Logger.getTime() + "]\n";
		Logger.writeToFile("Register", s);
	}  

}
