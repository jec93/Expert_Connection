package kr.or.iei.category.model.service;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;

@Configuration
public class KomoranConfig {
	@Bean
    public Komoran komoran() {
        Komoran komoran = new Komoran(DEFAULT_MODEL.FULL);
        try {
            String path = new ClassPathResource("komoran/user_dic.txt").getFile().getAbsolutePath();
            komoran.setUserDic(path); // 절대 경로 설정
            System.setProperty("file.encoding", "UTF-8"); 
        } catch (IOException e) {
            throw new RuntimeException("Failed to load Komoran user dictionary", e);
        }

        
        //return new Komoran(DEFAULT_MODEL.FULL); 기본형태
        return komoran;
    }
}
