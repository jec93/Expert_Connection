package kr.or.iei.category.model.vo;

public class RankKeywords {
	private int srchCnt;
	private String thirdCategoryCd;
	private String thirdCategoryNm;
	private String secondCategoryCd;
	public RankKeywords() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public RankKeywords(int srchCnt, String thirdCategoryCd, String thirdCategoryNm, String secondCategoryCd) {
		super();
		this.srchCnt = srchCnt;
		this.thirdCategoryCd = thirdCategoryCd;
		this.thirdCategoryNm = thirdCategoryNm;
		this.secondCategoryCd = secondCategoryCd;
	}

	public String getSecondCategoryCd() {
		return secondCategoryCd;
	}

	public void setSecondCategoryCd(String secondCategoryCd) {
		this.secondCategoryCd = secondCategoryCd;
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
