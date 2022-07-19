package member.pagination;

public class Pagination {
	private int page = 1;			// 현재 페이지
	private int startRow;			// DB에서 가져올 시작 줄
	private int endRow;				// DB에서 가져올 마지막 줄
	private int totalCount;			// 전체 행 개수
	private int totalPage;			// 전체 페이지 수
	private int rowNumber = 3;		// 화면에 보여줄 행 수
	private int pageNumber = 3;		// 화면에 보여줄 페이지 개수
	private int startPage;			// 화면에서 보여줄 시작 페이지
	private int endPage;			// 화면에서 보여줄 마지막 페이지
	private boolean prevActive;		// 이전 버튼 활성화 여부
	private boolean nextActive;		// 다음 버튼 활성화 여부
	
	// 현재 페이지와 해당 전체 행의 수를 입력받아 페이지 관련 설정
	public Pagination setPageination(int page, int totalCount) {
		this.page = page;
		this.totalCount = totalCount;
		
		calPagination();
		
		return this;
	}
	
	// 현재 페이지와 해당 전체 행의 수 및 화면에 보여줄 행의 수와 페이지 수를 입력받아 페이지 관련 설정
	public Pagination setPageination(int page, int totalCount, int rowNumber, int pageNumber) {
		this.page = page;
		this.totalCount = totalCount;
		this.rowNumber = rowNumber;
		this.pageNumber = pageNumber;
		
		calPagination();
		
		return this;
	}
	
	// 페이지 관련 계산하여 Pagination 클래스에 설정
	public void calPagination() {
		this.totalPage = (int) Math.ceil((double) totalCount/rowNumber);
		this.startRow = (page - 1) * rowNumber + 1;
		this.endRow = startRow - 1 + rowNumber;
		this.endRow = endRow > totalCount ? totalCount : endRow;
		this.startPage = (int) Math.floor((double) (page-1)/pageNumber) * pageNumber + 1;
		this.endPage = startPage - 1 + pageNumber;
		this.endPage = endPage > totalPage ? totalPage : endPage;
		this.prevActive = page > pageNumber;
		this.nextActive = endPage < totalPage;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getRowNumber() {
		return rowNumber;
	}
	public void setRowNumber(int rowNumber) {
		this.rowNumber = rowNumber;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrevActive() {
		return prevActive;
	}
	public void setPrevActive(boolean prevActive) {
		this.prevActive = prevActive;
	}
	public boolean isNextActive() {
		return nextActive;
	}
	public void setNextActive(boolean nextActive) {
		this.nextActive = nextActive;
	}
}
