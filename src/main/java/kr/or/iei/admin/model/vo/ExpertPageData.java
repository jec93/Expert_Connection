package kr.or.iei.admin.model.vo;

import java.util.ArrayList;

import kr.or.iei.member.model.vo.Expert;
import kr.or.iei.member.model.vo.Member;

public class ExpertPageData {
	
	private ArrayList<Expert> list;
	private String pageNavi;
	
	public ExpertPageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ExpertPageData(ArrayList<Expert> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	
	public ArrayList<Expert> getList() {
		return list;
	}
	public void setList(ArrayList<Expert> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	
	@Override
	public String toString() {
		return "ExpertPageData [list=" + list + ", pageNavi=" + pageNavi + "]";
	}
		
}
