package kr.or.iei.category.model.vo;

public class RankKeywords {
	private int srchCnt;
	private String thirdCategoryCd;
	private String thirdCategoryNm;
	public RankKeywords() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RankKeywords(int srchCnt, String thirdCategoryCd, String thirdCategoryNm) {
		super();
		this.srchCnt = srchCnt;
		this.thirdCategoryCd = thirdCategoryCd;
		this.thirdCategoryNm = thirdCategoryNm;
	}
	public int getSrchCnt() {
		return srchCnt;
	}
	public void setSrchCnt(int srchCnt) {
		this.srchCnt = srchCnt;
	}
	public String getThirdCategoryCd() {
		return thirdCategoryCd;
	}
	public void setThirdCategoryCd(String thirdCategoryCd) {
		this.thirdCategoryCd = thirdCategoryCd;
	}
	public String getThirdCategoryNm() {
		return thirdCategoryNm;
	}
	public void setThirdCategoryNm(String thirdCategoryNm) {
		this.thirdCategoryNm = thirdCategoryNm;
	}
	
}
