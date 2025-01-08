package kr.or.iei.category.model.vo;

public class Category {
	private String firstCategoryCd;
	private String firstCategoryNm;
	private String secondCategoryCd;
	private String secondCategoryNm;
	private String thirdCategoryCd;
	private String thirdCategoryNm;
	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Category(String firstCategoryCd, String firstCategoryNm, String secondCategoryCd, String secondCategoryNm,
			String thirdCategoryCd, String thirdCategoryNm) {
		super();
		this.firstCategoryCd = firstCategoryCd;
		this.firstCategoryNm = firstCategoryNm;
		this.secondCategoryCd = secondCategoryCd;
		this.secondCategoryNm = secondCategoryNm;
		this.thirdCategoryCd = thirdCategoryCd;
		this.thirdCategoryNm = thirdCategoryNm;
	}
	public String getFirstCategoryCd() {
		return firstCategoryCd;
	}
	public void setFirstCategoryCd(String firstCategoryCd) {
		this.firstCategoryCd = firstCategoryCd;
	}
	public String getFirstCategoryNm() {
		return firstCategoryNm;
	}
	public void setFirstCategoryNm(String firstCategoryNm) {
		this.firstCategoryNm = firstCategoryNm;
	}
	public String getSecondCategoryCd() {
		return secondCategoryCd;
	}
	public void setSecondCategoryCd(String secondCategoryCd) {
		this.secondCategoryCd = secondCategoryCd;
	}
	public String getSecondCategoryNm() {
		return secondCategoryNm;
	}
	public void setSecondCategoryNm(String secondCategoryNm) {
		this.secondCategoryNm = secondCategoryNm;
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
	@Override
	public String toString() {
		return "Category [firstCategoryCd=" + firstCategoryCd + ", firstCategoryNm=" + firstCategoryNm
				+ ", secondCategoryCd=" + secondCategoryCd + ", secondCategoryNm=" + secondCategoryNm
				+ ", thirdCategoryCd=" + thirdCategoryCd + ", thirdCategoryNm=" + thirdCategoryNm + "]";
	}
	
	
}
