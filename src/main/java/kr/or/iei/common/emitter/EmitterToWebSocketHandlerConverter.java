package kr.or.iei.common.emitter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;

@Component
public class EmitterToWebSocketHandlerConverter implements Converter<Emitter, WebSocketHandler> {

	@Override
	public WebSocketHandler convert(Emitter source) {
		// TODO Auto-generated method stub
		return new CustomWebSocketHandler(source);
	}

}
