
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
	
	
	pointcut signup(User u, Person p):
		call(void com.betting.BettingHouse.succesfully.)
	
	
}
