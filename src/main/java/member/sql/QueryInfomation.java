package member.sql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import DBPKG.DBConnection;

/** sql 관련 정보를 확인하기 위해 사용 */
public class QueryInfomation {
	private String sql; 									// query 값
	private Connection con; 								// DB Connection 객체
	private PreparedStatement ps; 							// DB에 query 및 parameter 설정 객체
	private ResultSet rs; 									// DB에서 결과 저장 객체
	private ArrayList<Object> paramList; 					// 파라미터 목록
	private int paramCount; 								// 파라미터 개수
	private HashMap<String, Object> result; 				// ResultSet에서 첫번째 결과 값 저장
	private ArrayList<HashMap<String, Object>> resultList; 	// ResultSet을 ArrayList 형태로 저장
	private int resultCount;								// ResultSet의 결과 값을 int 형태로 저장
	private int columnCount; 								// DB Column 개수
	private String[] columnNameList; 						// DB Column 이름 목록
	private String[] columnTypeNameList; 					// DB Column type 이름 목록
	private String printEndLine;

	// 1. query 설정
	public void setSql(String sql) {
		try {
			if(con == null) {
				con = new DBConnection().getConnecion();
			}
			ps = con.prepareStatement(sql);
			paramList = new ArrayList<>();
			paramCount = 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		this.sql = sql;
	}

	// (2-1. parameter 설정)
	public void setParameter(Object paremeter) {
		if (ps != null) {
			try {
				ps.setObject(++paramCount, paremeter);
				paramList.add(paremeter);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// 2-2. DB에서 결과 값 조회
	public ResultSet executeQuery() {
		try {
			if (ps != null) {
				System.out.println(">> QueryInformation > executeQuery");
				System.out.println("-- sql :\n" + sql);
				System.out.println("-- parameter : " + paramList);
				System.out.println(getPrintEndLine());
				
				rs = ps.executeQuery();
				resultCount = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return rs;
	}

	// 2-2. DB 수정
	public int executeUpdate() {
		int updateResult = 0;

		try {
			if (ps != null) {
				System.out.println(">> QueryInformation > executeUpdate");
				System.out.println("-- sql :\n" + sql);
				System.out.println("-- parameter : " + paramList);
				System.out.println(getPrintEndLine());

				updateResult = ps.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return updateResult;
	}

	// 3-1. DB 조회 시 meta data 설정
	public boolean setResultMetaDate() {
		try {
			rs = executeQuery();

			if (rs != null) {
				ResultSetMetaData rsmd = rs.getMetaData();
				columnCount = rsmd.getColumnCount();
				columnNameList = new String[columnCount];
				columnTypeNameList = new String[columnCount];

				for (int i = 0; i < columnCount; i++) {
					columnNameList[i] = rsmd.getColumnName(i + 1);
					columnTypeNameList[i] = rsmd.getColumnTypeName(i + 1);
				}
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return true;
	}

	// 3-2. DB 조회 첫번째 결과 값 반환
	public HashMap<String, Object> getResult() {
		try {
			if(setResultMetaDate() && rs.next()) {
				result = new HashMap<>();

				for(int i = 0; i < columnNameList.length; i++) {
					String columnName = columnNameList[i];

					if(columnTypeNameList[i].equals("NUMBER")) {
						result.put(columnName, Integer.parseInt(String.valueOf(rs.getObject(columnName))));
					} else {
						result.put(columnName, rs.getObject(columnName));
					}
				}
				resultCount++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}

	// 3-2. DB 조회 결과 값 목록 반환
	public ArrayList<HashMap<String, Object>> getResultList() {
		try {
			if(setResultMetaDate()) {
				resultList = new ArrayList<>();

				while(rs.next()) {
					result = new HashMap<>();

					for(int i = 0; i < columnNameList.length; i++) {
						String columnName = columnNameList[i];

						if(columnTypeNameList[i].equals("NUMBER")) {
							result.put(columnName, Integer.parseInt(String.valueOf(rs.getObject(columnName))));
						} else {
							result.put(columnName, rs.getObject(columnName));
						}
					}

					resultList.add(result);
					resultCount++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return resultList;
	}
	
	// 3-2. DB 조회 첫번째 값 int 형태로 반환
	public int getResultCount(String key) {
		resultCount = 0;
		
		try {
			if(setResultMetaDate()) {
				if(rs.next()) {
					resultCount = Integer.parseInt(String.valueOf(rs.getObject(key)));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return resultCount;
	}
	
	// DB 관련 객체를 닫음
	public void close() {
		System.out.println(">> QueryInformation > close");
		System.out.println(getPrintEndLine());

		try {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getCon() {
		return con;
	}

	public void setCon(Connection con) {
		this.con = con;
	}

	public String getSql() {
		return sql;
	}

	public ArrayList<Object> getParamList() {
		return paramList;
	}

	public void setParamList(ArrayList<Object> paramList) {
		this.paramList = paramList;
	}

	public PreparedStatement getPs() {
		return ps;
	}

	public void setPs(PreparedStatement ps) {
		this.ps = ps;
	}

	public ResultSet getRs() {
		return rs;
	}

	public void setRs(ResultSet rs) {
		this.rs = rs;
	}

	public int getParamCount() {
		return paramCount;
	}

	public void setParamCount(int paramCount) {
		this.paramCount = paramCount;
	}

	public void setResult(HashMap<String, Object> result) {
		this.result = result;
	}

	public void setResultList(ArrayList<HashMap<String, Object>> resultList) {
		this.resultList = resultList;
	}
	
	public int getResultCount() {
		return resultCount;
	}

	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
	}

	public int getColumnCount() {
		return columnCount;
	}

	public void setColumnCount(int columnCount) {
		this.columnCount = columnCount;
	}

	public String[] getColumnNameList() {
		return columnNameList;
	}

	public void setColumnNameList(String[] columnNameList) {
		this.columnNameList = columnNameList;
	}

	public String[] getColumnTypeNameList() {
		return columnTypeNameList;
	}

	public void setColumnTypeNameList(String[] columnTypeNameList) {
		this.columnTypeNameList = columnTypeNameList;
	}

	public String getPrintEndLine() {
		printEndLine = "";
		
		for(int i=0; i<100; i++) {
			printEndLine += "*";
		}
		return printEndLine;
	}
	public void setPrintEndLine(String printEndLine) {
		this.printEndLine = printEndLine;
	}
}
