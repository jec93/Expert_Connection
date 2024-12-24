<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.join-wrap {
	width: 100%;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.join-input-wrap {
	display: flex;
	flex-direction: column;
	margin-bottom: 15px;
}
.input-msg{
	margin-left : 390px;
}
.join-input-title {
	margin-bottom: 5px;
	margin-left : 390px;
}

.join-input-item {
	width: 50%;
	margin-left : 390px;
	display : flex;
}
.join-component{
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

button:hover {
	background-color: #0056b3;
}

.join-button-box {
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top: 30px;
}

.join-btn-primary {
	width : 140px;
	background-color: #34805C;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	color: #fff;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s;
}
.join-btn-primary:hover {
	background-color : #2f5233;
}

</style>
</head>

<div class="join-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section join-wrap">
				<div class="page-title">회원가입</div>
				<form action="/member/join.exco" method="post" autocomplete="off"
					onsubmit="return joinValidate()">
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberId">아이디</label>
						</div>
						<div class="join-input-item">
							<input type="text" id="memberId" name="memberId"
								placeholder="영어 , 숫자 포함 6~12글자" maxlength="12" class="join-component"/>
							<button type="button" id="idDuplChkBtn" class="join-btn-primary">중복체크</button>
						</div>
						<p id="idMessage" class="input-msg"></p>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberPw">비밀번호</label>
						</div>
						<div class="join-input-item">
							<input type="password" id="memberPw" name="memberPw"
								placeholder="영어 , 숫자 , 특수문자 포함 8~20글자" maxlength="20" class="join-component"/>
						</div>
						<p id="pwMessage" class="input-msg"></p>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberPwConfirm">비밀번호 확인</label>
						</div>
						<div class="join-input-item">
							<input type="password" id="memberPwConfirm" maxlength="20" class="join-component"/>
						</div>
						<p id="pwMessage" class="input-msg"></p>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberNickname">닉네임</label>
						</div>
						<div class="join-input-item">
							<input type="text" id="memberNickname" name="memberNickname"
								placeholder="한글,영어,숫자,특수문자 포함 2~10글자" maxlength="10" class="join-component">
							<button type="button" id="nickDuplChkBtn" class="join-btn-primary">중복체크</button>
						</div>
						<p id="nickMessage" class="input-msg"></p>
					</div>
					<div class="join-input-wrap">
						<label for="memberAddr" class="join-input-title">주소</label>
						<div class="join-input-item">
					
						 	<input type="hidden" id="zipp_code_id" name="zipp_code"
								maxlength="10" placeholder="우편번호"
								style="width: 50%; display: inline;" class="join-component">
								
							<input type="text" name="memberAddr" id="memberAddr" maxlength="40"
								placeholder="기본 주소를 입력하세요" required class="join-component">		
													
							<button type="button" id="zipp_btn" class="join-btn-primary"
								onclick="execDaumPostcode()" >도로명주소 찾기</button>				
						</div>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberPhone">전화번호</label>
						</div>
						<div class="join-input-item">
							<input type="text" id="memberPhone" name="memberPhone"
								placeholder="전화번호(010-0000-0000)" maxlength="13" class="join-component">
						</div>
						<p id="phoneMessage" class="input-msg"></p>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberPhoneCerti">전화번호 인증</label>
						</div>
						<div class="join-input-item">
							<input type="text" name="memberPhoneCerti" placeholder="전화번호 인증코드 입력" class="join-component"><br>
						</div>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberEmail">이메일</label>
						</div>
						<div class="join-input-item">
							<input type="email" id="memberEmail" name="memberEmail" class="join-component" placeholder="user@example.com">
						</div>
						<p id="emailMessage" class="input-msg"></p>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberEmailCerti">이메일 인증</label>
						</div>
						<div class="join-input-item">
							<input type="text" name="memberEmailCerti" placeholder="이메일 인증코드 입력" class="join-component"><br>
						</div>
					</div>	
					<div class="join-input-wrap">
						<label for="memberGender" class="join-input-title">성별</label>
						<div class="join-input-title">
							  <input type="radio" name="memberGender" value="0">남자
							  <input type="radio" name="memberGender" value="1">여자
							  <input type="radio" name="memberGender" value="2">비공개
						</div>
					</div>
					
					<div class="join-button-box">
						<button type="submit" class="join-btn-primary lg">회원가입</button>
					</div>
				</form>
			</section>
		</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	const checkObj = {
		"memberId" : false,
		"idDuplChk" : false,
		"nickDuplChk" : false,
		"memberPw" : false,
		"memberPwConfirm" : false,
		"memberNickname" : false,
		"memberPhone" : false		
	}
	
	const memberId = $('#memberId'); 
	const idMessage = $('#idMessage');
	

	memberId.on('input',function(){
		checkObj.memberIdChanged = true;
        checkObj.idDuplChk = false;
        idMessage.removeClass('valid');
        idMessage.removeClass('invalid');
        
        const regExp = /(?=.*[0-9])(?=.*[a-zA-z])[a-zA-Z0-9]{6,12}$/;
        
        if(regExp.test($(this).val())){ 
            idMessage.html("");
            idMessage.addClass("valid");
            checkObj.memberId = true;
        }else{
            idMessage.html("영어 + 숫자 6~12글자 사이로 입력하세요");
            idMessage.addClass("invalid");
            checkObj.memberId = false;
        }
    });
	
	
	$('#idDuplChkBtn').on('click', function(){
        if(!checkObj.memberId){
            msg("알림", "유효한 아이디를 입력한 후 중복체크를 진행하세요", "error");
            return false;
        }
        $.ajax({
            url : "/member/idDuplChk.exco",
            data : {"memberId" : memberId.val()},
            type : "get", 
            success : function(res){
                if(res == 0){
                    msg("알림", "사용 가능한 아이디입니다", "success");
                    checkObj.idDuplChk = true;
                }else {
                    msg("알림", "중복된 아이디가 존재합니다", "warning");
                    checkObj.idDuplChk = false;
                }
            },
            error : function(){
                console.log('ajax 오류 발생');
            }
        });
    });
	
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
			contentType: "application/json; charset=UTF-8",
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
	
	memberPw.on('input',function(){
		checkObj.memberPwChanged = true;
        pwMessage.removeClass('valid');
        pwMessage.removeClass('invalid');
        
        const regExp = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,20}$/;

        
        if(regExp.test($(this).val())){
            checkObj.memberPw = true;
            pwMessage.html("");
            pwMessage.addClass("valid");
         // 비밀번호가 유효할 때만 비밀번호 확인 일치 여부를 검사
            if (memberPwConfirm.val() !== "") {
                checkPasswordMatch();
            }
        }else{
            pwMessage.html("비밀번호 형식이 유효하지 않습니다");
            pwMessage.addClass("invalid");
            checkObj.memberPw = false;
         // 비밀번호 형식이 유효하지 않으면 비밀번호 확인 메시지 초기화
            pwConfirmMessage.html("");
            pwConfirmMessage.removeClass('valid invalid');
            checkObj.memberPwConfirm = false;
        }
    });
	
	const memberPwConfirm = $('#memberPwConfirm');
    memberPwConfirm.on('input', function(){
        if(memberPwConfirm.val() === memberPw.val()){
            pwMessage.addClass('valid');
            pwMessage.html('');
            checkObj.memberPwConfirm = true;
        }else{
            pwMessage.addClass('invalid');
            pwMessage.html('비밀번호가 일치하지 않습니다');
            checkObj.memberPwConfirm = false;
        }
    });
    
    function checkPasswordMatch() {
        pwConfirmMessage.removeClass('valid invalid');

        if (dinnerPw.val() === dinnerPwConfirm.val()) {
            pwConfirmMessage.html("비밀번호가 일치합니다");
            pwConfirmMessage.addClass('valid');
            checkObj.dinnerPwConfirm = true;
        } else {
            pwConfirmMessage.html("비밀번호가 일치하지 않습니다");
            pwConfirmMessage.addClass('invalid');
            checkObj.dinnerPwConfirm = false;
        }
    }
	
	const memberPhone = $('#memberPhone');
	const phoneMessage = $('#phoneMessage');
	
	memberPhone.on('input', function(){
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
		
		for(let key in checkObj){

			if(!checkObj[key]){
				switch(key){ 
				case "memberId" : str = "아이디 형식이 유효하지 않습니다"; break;
				case "idDuplChk" : str = "아이디 중복체크를 진행하세요"; break;
				case "nickDuplChk" : str = "닉네임 중복체크를 진행하세요"; break;
				case "memberPw" : str = "비밀번호 형식이 유효하지 않습니다"; break;
				case "memberPwConfirm" : str = "비밀번호 확인 형식이 유효하지 않습니다"; break;
				case "memberPhone" : str = "전화번호 형식이 유효하지 않습니다"; break;
				}
				 
				 str += "";
		         msg("회원가입 실패", str, "error");  // 오류 메시지를 출력하는 함수 호출
		         return false;  // 유효하지 않으면 false 반환하여 폼 제출 중지
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