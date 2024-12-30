package kr.or.iei.chat.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.chat.model.dao.AutoResDao;

@Service("autoResService")
public class AutoResService {
	
	@Autowired
	@Qualifier("autoResDao")
	private AutoResDao autoResDao;

}
