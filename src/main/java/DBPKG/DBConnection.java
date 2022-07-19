package DBPKG;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnecion() {
		Connection con = null;
		String url = "jdbc:oracle:thin:@localhost:1521/xe";
		String userName = "hyein";
		String pw = "9148";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection(url, userName, pw);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
}
