package member;

import java.sql.Timestamp;

/** 회원 정보 DTO */
public class MemberDTO {
	private int num;				// 회원 일련번호
	private String id;				// 회원 아이디
	private String password;		// 회원 비밀번호
	private String name;			// 회원 이름
	private String phone;			// 회원 전화번호
	private String address;			// 회원 주소
	private Timestamp joindate;		// 회원 가입일
	private Timestamp modifydate;	// 회원 정보 수정일
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Timestamp getJoindate() {
		return joindate;
	}
	public void setJoindate(Timestamp joindate) {
		this.joindate = joindate;
	}
	public Timestamp getModifydate() {
		return modifydate;
	}
	public void setModifydate(Timestamp modifydate) {
		this.modifydate = modifydate;
	}
}
