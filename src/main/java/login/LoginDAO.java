package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;

import DBPKG.DBConnect;

public class LoginDAO {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	public LoginDAO() {
		try {
			con=DBConnect.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int getCon(String id,String pwd) {
		System.out.println("id:"+id);
		System.out.println("pwd:"+pwd);
		String sql="select * from promember where id = ?";
		int result=0;
		
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			
			
			
			
			if(rs.next()) {
				if (pwd.equals(rs.getString("pwd"))) {
					System.out.println("로그인 성공");
					result=1;
				}else {
					result=0;
					System.out.println("비밀번호가 다릅니다.");
				}
			}else {
				result=-1;
				System.out.println("아이디가 존재하지 않습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	

}
