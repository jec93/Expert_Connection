package kr.or.iei.common.emitter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.HashMap;

@Controller("emitterHandler")
public class Emitter {

    private HashMap<String, SseEmitter> members;
    
    public Emitter() {
		members = new HashMap<String, SseEmitter>();
	}

    @GetMapping(path = "/emitter", produces = "text/event-stream")
    //UTF-8 데이터만 보낼 수 있음, 바이너리 데이터 지원 x 
    public SseEmitter subscribe(String memberNo) {
        SseEmitter emitter = connect(memberNo);
        return emitter;
    }

    public SseEmitter connect(String memberNo) {
        SseEmitter sseEmitter = new SseEmitter(3000 * 10000L); // 타임아웃 설정 5분
        members.put(memberNo, sseEmitter);
        sseEmitter.onCompletion(() -> members.remove(memberNo));
        sseEmitter.onTimeout(() -> members.remove(memberNo));
        return sseEmitter;
    }
    
    //알림 메시지만 전송
    public void sendEvent(String memberNo, String msg) {
        SseEmitter sseEmitter = members.get(memberNo);
        if (sseEmitter != null) {
            try {
            	HashMap<String, String> notification = new HashMap<>();
                notification.put("message", msg);
                sseEmitter.send(SseEmitter.event().name("message").data(notification));
            } catch (IOException e) {
                sseEmitter.complete();
                members.remove(memberNo);
            }
        }
    }

    //알림 메시지만 전송
    public void sendBroadcastEvent(String msg) {
        for (SseEmitter sseEmitter : members.values()) {
            try {
                sseEmitter.send(SseEmitter.event().name("message").data(msg));
            } catch (IOException e) {
                sseEmitter.complete();
            }
        }
    }
    
    //알림 메시지와 url을 전송
    public void sendBroadcastEvent(String msg, String url) {
        for (SseEmitter sseEmitter : members.values()) {
            try {
                HashMap<String, String> notification = new HashMap<>();
                notification.put("message", msg);
                notification.put("url", url);
                
                sseEmitter.send(SseEmitter.event().name("message").data(notification));
            } catch (IOException e) {
                sseEmitter.complete();
            }
        }
    }

}
