package kr.or.iei.common.emitter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;

@Controller("emitterHandler")
public class Emitter {

    private HashMap<String, SseEmitter> members;
    
    public Emitter() {
		members = new HashMap<>();
	}

    @PostMapping("registerSseEmitter")
    public SseEmitter registerSseEmitter(@RequestParam String memberNo) {
        SseEmitter emitter = new SseEmitter();
        members.put(memberNo, emitter);
        return emitter;
    }
    
    /*
    @PostConstruct
    public void init() {
        register("admin", new SseEmitter());
    }
    */
    
    @PostConstruct
    public void init() {
        SseEmitter adminEmitter = new SseEmitter();
        members.put("admin", adminEmitter); // 여기서 ID는 관리자 member ID
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
    
    // 알림 메시지와 URL 전송
    public void sendEvent(String memberNo, String msg, String url) {
        SseEmitter sseEmitter = members.get(memberNo);
        if (sseEmitter != null) {
            try {
                Map<String, String> notification = new HashMap<>();
                notification.put("message", msg);
                if (url != null) {
                    notification.put("url", url);
                }
                sseEmitter.send(SseEmitter.event().name("message").data(notification));
            } catch (IOException e) {
                sseEmitter.complete();
                members.remove(memberNo);
            }
        } else {
            System.out.println("유효하지 않은 사용자 또는 SseEmitter를 찾을 수 없습니다.");
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
    
    
    // members 맵에서 각 사용자의 memberNo와 SseEmitter를 올바르게 매핑했는지 확인
    HashMap<String, SseEmitter> member = new HashMap<>(); // 애플리케이션 초기화 때 설정해둔 부분

    public void register(String memberNo, SseEmitter sseEmitter) {
        member.put(memberNo, sseEmitter);
    }


}
