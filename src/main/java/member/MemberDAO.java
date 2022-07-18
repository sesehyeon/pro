package member;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import member.pagination.Pagination;
import member.sql.QueryInfomation;

/** 회원 정보 DAO */
public class MemberDAO {
	// 회원가입
	public int join(MemberDTO memberDTO) {
		QueryInfomation queryInfo = new QueryInfomation();
		String sql = "insert into member_0712(num, id, password, name, phone, address, joindate)"
				+ " values(member_0712_seq.nextval, ?, ?, ?, ?, ?, sysdate)";
		int result = 0;
		
		try {
			queryInfo.setSql(sql);
			
			queryInfo.setParameter(memberDTO.getId());
			queryInfo.setParameter(memberDTO.getPassword());
			queryInfo.setParameter(memberDTO.getName());
			queryInfo.setParameter(memberDTO.getPhone());
			queryInfo.setParameter(memberDTO.getAddress());

			result = queryInfo.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	// 아이디 중복확인
	public int checkId(String id) {
		QueryInfomation queryInfo = new QueryInfomation();
		String sql = "select count(*) IdCount from member_0712 where id = ?";
		int result = -1;
	
		try {
			if(id == null || id.length() == 0) {
				return result;
			}
			
			queryInfo.setSql(sql);
			queryInfo.setParameter(id);
			
			result = queryInfo.getResultCount("IDCOUNT");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 해당 조건의 회원목록 반환
	public ArrayList<MemberDTO> getMemberList(SearchDTO searchDTO, Pagination pagination) {
		QueryInfomation queryInfo = new QueryInfomation();
		ArrayList<MemberDTO> memberList = new ArrayList<>();
		ArrayList<HashMap<String, Object>> resultList = null;
		String sql = "";
				
		try {
			sql = makeSearchQuery(searchDTO, "paging");
			
			queryInfo.setSql(sql);
			
			if(searchDTO.isSearch()) {
				String keyword = searchDTO.getKeyword();
				
				for(int i=0; i<searchDTO.getConditionCount(); i++) {
					queryInfo.setParameter("%" + keyword + "%");
				}
			} 
			
			queryInfo.setParameter(pagination.getStartRow());
			queryInfo.setParameter(pagination.getEndRow());

			resultList = queryInfo.getResultList();

			for(HashMap<String, Object> result : resultList) {
				memberList.add(getMemberDTO(result));
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return memberList;
	}
	
	// 해당 조건의 전체 회원수 반환
	public int getTotalCount(SearchDTO searchDTO) {
		QueryInfomation queryInfo = new QueryInfomation();
		int totalCount = 0;
		String target = "count";
		String sql = "";
		
		try {
			sql = makeSearchQuery(searchDTO, target);
			
			if (sql != null) {
				queryInfo.setSql(sql);
				
				if(searchDTO.isSearch()) {
					String keyword = searchDTO.getKeyword();
					
					for(int i=0; i<searchDTO.getConditionCount(); i++) {
						queryInfo.setParameter("%" + keyword + "%");
					}
				}
				
				totalCount = queryInfo.getResultCount(target.toLowerCase());
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// 회원 상세정보 반환
	public MemberDTO getMemberDetail(int num) {
		QueryInfomation queryInfo = new QueryInfomation();
		HashMap<String, Object> result = null;
		MemberDTO memberDTO = null;
		String sql = "select * from member_0712 where num = ?";
		
		try {
			queryInfo.setSql(sql);
			queryInfo.setParameter(num);
		
			result = queryInfo.getResult();
			
			if(result != null) {
				memberDTO = getMemberDTO(result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return memberDTO;
	}
	
	// 회원 정보 수정
	public int modify(MemberDTO memberDTO) {
		QueryInfomation queryInfo = new QueryInfomation();
		String sql = "update member_0712 set password = ?, name = ?, phone = ?, address = ?"
				+ " where num = ?";
		int result = 0;
		
		try {
			queryInfo.setSql(sql);
			
			queryInfo.setParameter(memberDTO.getPassword());
			queryInfo.setParameter(memberDTO.getName());
			queryInfo.setParameter(memberDTO.getPhone());
			queryInfo.setParameter(memberDTO.getAddress());
			queryInfo.setParameter(memberDTO.getNum());
			
			result = queryInfo.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// MemberDTO에 QueryInformation에서 가져온 정보 맵핑
	public MemberDTO getMemberDTO(HashMap<String, Object> result) {
		MemberDTO memberDTO = new MemberDTO();
		
		try {
			memberDTO.setNum((int) result.get("NUM"));
			memberDTO.setId((String) result.get("ID"));
			memberDTO.setPassword((String) result.get("PASSWORD"));
			memberDTO.setName((String) result.get("NAME"));
			memberDTO.setPhone((String) result.get("PHONE"));
			memberDTO.setAddress((String) result.get("ADDRESS"));
			memberDTO.setJoindate((Timestamp)result.get("JOINDATE"));
			memberDTO.setModifydate((Timestamp)result.get("MODIFYDATE"));
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return memberDTO;
	}
	
	// 해당 조건에 맞는 select query 생성 및 반환
	public String makeSearchQuery(SearchDTO searchDTO, String type) {
		String searchSql = null;
		
		try {
			if(searchDTO != null) {
				String[] conditionNameList = searchDTO.getConditionNameList();
				String sortColumnName = searchDTO.getSortColumnName();
				String sortTypeName = searchDTO.getSortTypeName();
				String selectTarget = "*";
				
				searchSql = new String();
				
				/* type:
				 * 1. count(해당 조건의 회원수)
				 * 2. paging(해당 조건으로 paging 처리된 회원 모든 정보 목록)
				 * 3. ""(해당조건으로 처리된 회원 모든 정보 목록)
				 */
				if(type.equals("count")) {
					selectTarget = "count(*) count";
				} else if(type.equals("paging")) {
					searchSql = "select * from\r\n"
							+"(";
					selectTarget = "rownum rn, member.*";
				}	
					
				searchSql += "select " + selectTarget +" from (select * from member_0712";
				
				// 검색 조건과 검색어가 있을 경우
				if(searchDTO.isSearch()) {
					searchSql += " where";
					
					for(int i=0; i<conditionNameList.length; i++) {
						String conditionName = conditionNameList[i];
						
						if(i > 0) {
							searchSql += " or";
						}
						searchSql += " " + conditionName + " like ?";
					}
				} 
				
				// 정렬 기준이 있을 경우
				if(sortColumnName != null) {
					searchSql += " order by " + sortColumnName;
					
					if(sortTypeName != null) {
						searchSql += " " + sortTypeName;
					}
				}
				
				searchSql += ") member";
				
				if(type.equals("paging")) {
					searchSql += ")\r\n"
							+ "where rn between ? and ?";
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return searchSql;
	}
}
