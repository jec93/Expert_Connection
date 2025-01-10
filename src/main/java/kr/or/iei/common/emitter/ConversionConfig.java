package kr.or.iei.common.emitter;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.ConversionService;
import org.springframework.core.convert.support.DefaultConversionService;

@Configuration
public class ConversionConfig {

	@Bean
	public ConversionService conversionService() {
		DefaultConversionService service = new DefaultConversionService();
		service.addConverter(new EmitterToWebSocketHandlerConverter());
		return service;
	}
}
