package member;

/** 회원 검색 DTO */
public class SearchDTO {
	private int[] conditionList;		// 회원 검색 조건을 숫자 목록으로 입력 받음
	private String[] conditionNameList;	// 입력 받은 회원 검색 조건 숫자로 DB column name 설정
	private int conditionCount = 0;		// 입력 받은 조건 개수
	private String keyword;				// 검색어
	private int sortColumn;				// 정렬 column을 숫자로 입력 받음
	private int sortType = 0;			// 정렬 타입을 숫자로 입력 받음(오름차순 0, 내림차순 1)
	private String sortColumnName;		// 입력 받은 숫자로 정렬 column name 설정
	private String sortTypeName;		// 입력 받은 숫자로 정렬 타입 설정
	
	public SearchDTO setSearchDTO(int[] conditionList, String keyword, int sortColumn, int sortType) {
		this.conditionList = conditionList;
		this.keyword = keyword;
		this.sortColumn = sortColumn;
		this.sortType = sortType;
		
		if(conditionList != null && conditionList.length > 0) {
			this.conditionCount = conditionList.length;
			this.conditionNameList = new String[conditionCount];
			
			for(int i=0; i<conditionList.length; i++) {
				int condition = conditionList[i];
				String conditionName = "";
				
				switch(condition) {
				case 1 : conditionName = "id";
					break;
				case 2 : conditionName = "name";
					break;
				case 3 : conditionName = "phone";
					break;	
				case 4 : conditionName = "address";
					break;
				case 5 : conditionName = "to_char(joindate, 'yyyy-mm-dd')";
					break;
				case 6 : conditionName = "to_char(modifydate, 'yyyy-mm-dd')";
					break;		
				}
				
				conditionNameList[i] = conditionName;
			}
		} else {
			this.conditionNameList = null;
		}		
		
		switch(sortColumn) {
		case 1 : this.sortColumnName = "num";
			break;
		case 2 : this.sortColumnName = "id";
			break;
		case 3 : this.sortColumnName = "name";
			break;
		case 4 : this.sortColumnName = "phone";
			break;	
		case 5 : this.sortColumnName = "joindate";
			break;
		case 6 : this.sortColumnName = "modifydate";
			break;	
		default : this.sortColumnName = null;
			break;
		}
		
		switch(sortType) {
		case 0 : this.sortTypeName = "asc";
			break;
		case 1 : this.sortTypeName = "desc";
			break;
		default : this.sortTypeName = null;
			break;	
		}
		return this;
	}
	
	// 검색여부 반환
	public boolean isSearch() {
		return conditionList != null && conditionList.length > 0 && this.keyword != null && this.keyword.length() > 0;
	}
	
	public int[] getConditionList() {
		return conditionList;
	}
	public void setConditionList(int[] conditionList) {
		this.conditionList = conditionList;
	}
	public String[] getConditionNameList() {
		return conditionNameList;
	}
	public void setConditionNameList(String[] conditionNameList) {
		this.conditionNameList = conditionNameList;
	}
	public int getConditionCount() {
		return conditionCount;
	}
	public void setConditionCount(int conditionCount) {
		this.conditionCount = conditionCount;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getSortColumn() {
		return sortColumn;
	}
	public void setSortColumn(int sortColumn) {
		this.sortColumn = sortColumn;
	}
	public int getSortType() {
		return sortType;
	}
	public void setSortType(int sortType) {
		this.sortType = sortType;
	}
	public String getSortColumnName() {
		return sortColumnName;
	}
	public void setSortColumnName(String sortColumnName) {
		this.sortColumnName = sortColumnName;
	}
	public String getSortTypeName() {
		return sortTypeName;
	}
	public void setSortTypeName(String sortTypeName) {
		this.sortTypeName = sortTypeName;
	}
}
