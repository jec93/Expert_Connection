<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.update-wrap {
	width: 100%;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.update-input-wrap {
	display: flex;
	flex-direction: column;
	margin-bottom: 15px;
}
.input-msg{
	margin-left : 390px;
}
.update-input-title {
	margin-bottom: 5px;
	margin-left : 390px;
}

.update-input-item {
	width: 50%;
	margin-left : 390px;
	display : flex;
}
.update-gender{
	margin-left : 390px;
}
.update-component{
	border-top : none;
	border-right : none;
	border-left : none;
	border-color: gray;
	border-width : 1px;
	height : 40px;
	width : 600px;
	font-size : 16px;
}

input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus
	{
	border-color: #808080;
	box-shadow: 0 0 5px rgba(128, 128, 128, 0.5);
	outline: none;
}
.update-button-box {
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top: 30px;
}

.update-btn-primary {
	width : 140px;
	background-color:#34805C;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	color: #fff;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s;
}
.update-btn-primary:hover{
	background-color : #2f5233;
}
.update-btn-primary-chk {
	width : 140px;
	background-color:#34805C;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	color: #fff;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s;
}
.update-btn-primary-chk:hover{
	background-color : #2f5233;
}
</style>
</head>

<div class="update-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section update-wrap">
				<div class="page-title">회원정보 수정</div>
				<form action="/member/update.exco" method="post" autocomplete="off"
					onsubmit="return joinValidate()">
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberId">아이디</label>
						</div>
						<div class="update-input-item">
							<input type="text" id="memberId" name="memberId"
								placeholder=${loginMember.memberId} readonly class="update-component"/>
						</div>
						<p id="idMessage" class="input-msg"></p>
					</div>
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberPw">비밀번호</label>
						</div>
						<div class="update-input-item">
							<input type="password" id="memberPw" name="memberPw"
								placeholder="영어 , 숫자 , 특수문자 포함 8~20글자" maxlength="20" value="${loginMember.memberPw}" class="update-component"/>
						</div>
					</div>
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberPwConfirm">비밀번호 확인</label>
						</div>
						<div class="update-input-item">
							<input type="password" id="memberPwConfirm" maxlength="20" class="update-component" class="update-component" />
						</div>
						<p id="pwMessage" class="input-msg"></p>
					</div>
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberNickname">닉네임</label>
						</div>
						<div class="update-input-item">
							<input type="text" id="memberNickname" name="memberNickname"
								placeholder="한글,영어,숫자,특수문자 포함 2~10글자" maxlength="10"  value="${loginMember.memberNickname}" class="update-component">
							<button type="button" id="nickDuplChkBtn" class="update-btn-primary">중복체크</button>
						</div>
						<p id="nickMessage" class="input-msg"></p>
					</div>
					<div class="update-input-wrap">
						<label for="memberAddr" class="update-input-title">주소</label>
						<div class="update-input-item">
					
						 	<input type="hidden" id="zipp_code_id" name="zipp_code"
								maxlength="10" placeholder="우편번호"
								style="width: 50%; display: inline;">
								
							<input type="text" name="memberAddr" id="memberAddr" maxlength="40"
								placeholder="기본 주소를 입력하세요" required value="${loginMember.memberAddr}" class="update-component">
								
							<button type="button" id="zipp_btn" class="update-btn-primary"
								onclick="execDaumPostcode()">도로명주소 찾기</button>				
						</div>
					</div>
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberPhone">전화번호</label>
						</div>
						<div class="update-input-item">
							<input type="text" id="memberPhone" name="memberPhone"
								placeholder="전화번호(010-0000-0000)" maxlength="13" value="${loginMember.memberPhone}" class="update-component">
						</div>
						<p id="phoneMessage" class="input-msg"></p>
					</div>
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberPhoneCerti">전화번호 인증</label>
						</div>
						<div class="update-input-item">
							<input type="text" name="memberPhoneCerti" placeholder="전화번호 인증코드 입력" class="update-component"><br>
						</div>
					</div>
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberEmail">이메일</label>
						</div>
						<div class="update-input-item">
							<input type="email" id="memberEmail" name="memberEmail" value="${loginMember.memberEmail}" class="update-component">
							<button type="button" id="mailChkBtn" class="update-btn-primary">본인인증</button>
						</div>
						<p id="emailMessage" class="input-msg"></p>
					</div>
					<div class="update-input-wrap">
						<div class="update-input-title">
							<label for="memberEmailCerti">이메일 인증</label>
						</div>
						<div class="update-input-item">
							<input type="text" name="memberEmailCerti" id="memberEmailCerti" placeholder="이메일 인증코드 입력" class="update-component" maxlength="6"><br>
							<div>
								<button type="button" id="mailChkWarn" class="update-btn-primary-chk">인증번호 확인</button>
							</div>
						</div>
						<div id="mailChkMessage" class="input-msg"></div>
					</div>	
					<div class="update-input-wrap">
						<label for="memberGender" class="update-gender">성별</label>
						<div class="update-input-title" >
						<c:choose>
					    <c:when test="${loginMember.memberGender == 0}">
					      <input type="radio" name="memberGender" value="0" checked>남자
					    </c:when>
					    <c:otherwise>
					      <input type="radio" name="memberGender" value="0">남자
					    </c:otherwise>
					  </c:choose>
					  <c:choose>
					    <c:when test="${loginMember.memberGender == 1}">
					      <input type="radio" name="memberGender" value="1" checked>여자
					    </c:when>
					    <c:otherwise>
					      <input type="radio" name="memberGender" value="1">여자
					    </c:otherwise>
					  </c:choose>
					  <c:choose>
					    <c:when test="${loginMember.memberGender == 2}">
					      <input type="radio" name="memberGender" value="2" checked>비공개
					    </c:when>
					    <c:otherwise>
					      <input type="radio" name="memberGender" value="2">비공개
					    </c:otherwise>
					  </c:choose>
					    </div>
					</div>
					<div class="update-button-box">
						<button type="submit" class="update-btn-primary lg">정보수정</button>
					</div>
				</form>
			</section>
		</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	$(document).ready(function() {
	    let sentCode = '';  // 서버에서 받은 인증번호

	    // 본인 인증 버튼 클릭 시
	    $('#mailChkBtn').click(function() {
	        const email = $('#memberEmail').val(); // 이메일 주소값 얻어오기

	        // 이메일 입력값이 없으면 경고
	        if (!email) {
	            $('#emailMessage').text('이메일을 입력해주세요.').css('color', 'red');
	            return;
	        }

	        // 이메일 유효성 검사
	        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
	        if (!emailPattern.test(email)) {
	            $('#emailMessage').text('유효한 이메일 주소를 입력해주세요.').css('color', 'red');
	            return;
	        }

	        // 이메일을 통한 인증번호 요청
	        $.ajax({
	            type: 'GET',
	            url: '/member/mailCheck.exco',
	            data: { email: email },
	            success: function(response) {
	                sentCode = response;  // 서버에서 받은 인증번호 저장
	                alert('인증번호가 전송되었습니다.');
	                $('#memberEmailCerti').attr('disabled', false);  // 인증코드 입력란 활성화
	                $('#mailChkWarn').attr('disabled', false);  // 인증번호 확인 버튼 활성화
	            },
	            error: function() {
	                alert('인증번호 전송 실패');
	            }
	        });
	    });
	const checkObj = {
		"nickDuplChk" : false,
		"memberPw" : false,
		"memberPwConfirm" : false,
		"memberNickname" : false,
		"memberPhone" : false,	
	    "memberPwChanged": false,
	    "memberNickChanged": false,
	    "memberPhoneChanged": false
	}
	
	const memberNickname = $('#memberNickname'); 
	const nickMessage = $('#nickMessage');
	
	memberNickname.on('input',function(){
		checkObj.memberNickChanged = true;
		checkObj.nickDuplChk = false;
		
		nickMessage.removeClass('valid');
		nickMessage.removeClass('invalid');
		
		const regExp = /^[가-힣a-zA-z0-9!@#$%^&*()-_=+]{2,10}$/;
		
		if(regExp.test($(this).val())){ 
			nickMessage.html("");
			nickMessage.addClass("valid");
			checkObj.memberNickname = true;
		}else{
			nickMessage.html("한글,영어,숫자,특수문자 2~10글자 사이로 입력하세요")
			nickMessage.addClass("invalid");
			checkObj.memberNickname = false;
		}
	});
	
	$('#nickDuplChkBtn').on('click', function(){
		
		if(!checkObj.memberNickname){
			msg("알림", "유효한 닉네임을 입력한 후 중복체크를 진행하세요", "error");
			return false; 
		}
		
		$.ajax({
			url : "/member/nickDuplChk.exco",
			data : {"memberNickname" : memberNickname.val()},
			type : "get", 
			success : function(res){
				if(res == 0){
					msg("알림", "사용 가능한 닉네임입니다", "success");
					checkObj.nickDuplChk = true;
				}else {
					msg("알림", "중복된 닉네임이 존재합니다", "warning");
					checkObj.nickDuplChk = false;
				}
			},
			error : function(){
				console.log('ajax 오류 발생');
			}
		})
		
	});
	
	const memberPw = $('#memberPw');
	const pwMessage = $('#pwMessage');
	
	memberPw.on('input', function() {
	    checkObj.memberPwChanged = true;
	    pwMessage.removeClass('valid');
	    pwMessage.removeClass('invalid');
	    
	    const regExp = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,20}$/;

	    if (regExp.test($(this).val())) {
	        checkObj.memberPw = true;
	        pwMessage.html("");
	        pwMessage.addClass("valid");

	        // 비밀번호가 유효할 경우 비밀번호 확인 입력 필드를 활성화
	        $('#memberPwConfirm').prop('disabled', false);  // 비밀번호 확인 필드를 활성화
	        checkPasswordMatch(); // 비밀번호 확인 일치 여부 체크
	    } else {
	        pwMessage.html("비밀번호 형식이 유효하지 않습니다");
	        pwMessage.addClass("invalid");
	        checkObj.memberPw = false;
	        
	        // 비밀번호가 유효하지 않으면 비밀번호 확인 필드를 비활성화
	        $('#memberPwConfirm').prop('disabled', true);  // 비밀번호 확인 필드를 비활성화
	        pwConfirmMessage.html("");
	        pwConfirmMessage.removeClass('valid invalid');
	        checkObj.memberPwConfirm = false;
	    }
	});
	
	const memberPwConfirm = $('#memberPwConfirm');
	const pwConfirmMessage = $('#pwConfirmMessage');

	memberPwConfirm.on('input', function() {
	    if (memberPwConfirm.val() === memberPw.val()) {
	        pwConfirmMessage.addClass('valid');
	        pwConfirmMessage.html('비밀번호가 일치합니다');
	        checkObj.memberPwConfirm = true;  // 비밀번호 확인이 일치하면 true
	    } else {
	        pwConfirmMessage.addClass('invalid');
	        pwConfirmMessage.html('비밀번호가 일치하지 않습니다');
	        checkObj.memberPwConfirm = false;  // 비밀번호 확인이 일치하지 않으면 false
	    }
	});
    
	function checkPasswordMatch() {
	    if (memberPwConfirm.val() === memberPw.val()) {
	        pwConfirmMessage.removeClass('invalid');
	        pwConfirmMessage.addClass('valid');
	        pwConfirmMessage.html('비밀번호가 일치합니다');
	        checkObj.memberPwConfirm = true;
	    } else {
	        pwConfirmMessage.removeClass('valid');
	        pwConfirmMessage.addClass('invalid');
	        pwConfirmMessage.html('비밀번호가 일치하지 않습니다');
	        checkObj.memberPwConfirm = false;
	    }
    }
	
	const memberPhone = $('#memberPhone');
	const phoneMessage = $('#phoneMessage');
	
	memberPhone.on('input', function(){
		checkObj.memberPhoneChanged = true;
		phoneMessage.removeClass('valid');
		phoneMessage.removeClass('invalid');
		
		const regExp = /^010-\d{3,4}-\d{4}$/;
		
		if(regExp.test($(this).val())){
			phoneMessage.addClass('valid');
			phoneMessage.html("");
			checkObj.memberPhone = true;
		}else{
			phoneMessage.addClass('invalid');
			phoneMessage.html("전화번호 형식이 유효하지 않습니다");
			checkObj.memberPhone = false;
		}
	});
	
	function joinValidate(){
	    let str = "";

	    // 중복 체크가 필요한 항목 확인
	    if(!checkObj.idDuplChk && checkObj.memberIdChanged){
	        str = "아이디 중복체크를 진행하세요";
	        msg("정보수정 실패", str, "error");
	        return false;
	    }

	    if(!checkObj.nickDuplChk && checkObj.memberNickChanged){
	        str = "닉네임 중복체크를 진행하세요";
	        msg("정보수정 실패", str, "error");
	        return false;
	    }
	    // 비밀번호를 변경한 경우, 비밀번호 확인이 유효한지 확인
	    if (checkObj.memberPwChanged && !checkObj.memberPwConfirm) {
	        str = "비밀번호 확인이 일치하지 않습니다";
	        msg("정보수정 실패", str, "error");
	        return false;
	    }

	    // 형식 검증이 필요한 항목만 확인
	    for(let key in checkObj){
	        // 중복 체크와 관련 없는 항목이며, 변경된 항목만 확인
	        if(checkObj[key + "Changed"] && !checkObj[key]){  
	            switch(key){
	                case "memberId": str = "아이디 형식이 유효하지 않습니다"; break;
	                case "memberPw": str = "비밀번호 형식이 유효하지 않습니다"; break;
	                case "memberPwConfirm": str = "비밀번호 확인 형식이 유효하지 않습니다"; break;
	                case "memberName": str = "이름 형식이 유효하지 않습니다"; break;
	                case "memberPhone": str = "전화번호 형식이 유효하지 않습니다"; break;
	            }
	            str += "";
	            msg("정보수정 실패", str, "error");
	            return false;
	        }
	    }
	    return true;
	
	}
	
    function msg(title, text, icon){
        swal({
            title : title,
            text : text,
            icon : icon
        });     
    }
    
    
	</script>
	 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- CDN 방식 사용 -->
    <script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업을 통한 검색 결과 항목 클릭 시 실행
                var addr = ''; // 주소_결과값이 없을 경우 공백 
                var extraAddr = ''; // 참고항목

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 도로명 주소를 선택
                    addr = data.roadAddress;
                } else { // 지번 주소를 선택
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                } else {
                    document.getElementById("memberAddr").value = '';
                }

                // 선택된 우편번호와 주소 정보를 input 박스에 넣는다.
                document.getElementById('zipp_code_id').value = data.zonecode;
                document.getElementById("memberAddr").value = addr;
                document.getElementById("memberAddr").value += extraAddr;
            }
        }).open();
    }
	</script>
</body>
</html>