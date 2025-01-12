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
.custom-file-button{
	width : 56px;
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
	background-color : #7CBBAD;;
}
.file-name{
	display: flex;
	justify-content: center;
	align-items: center;
	margin-left : 10px;
}
.join-btn-primary-chk{
	width : 135px;
	background-color: #34805C;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	color: #fff;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s;
}
.join-btn-primary-chk:hover {
	background-color : #7CBBAD;
}

</style>
<script type="text/javascript">
        window.onload = function() {
            var message = "${message}";
            var error = "${error}";

            if (message) {
                alert(message);  // 성공 메시지
            } else if (error) {
                alert(error);  // 실패 메시지
            }
        };
</script>
</head>
<body>
<div class="join-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section join-wrap">
				<div class="page-title">회원가입</div>
				<form action="/member/joinExpert.exco" method="post" autocomplete="off" enctype="multipart/form-data"
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
							<c:if test="${memberAddr != null}">
								<input type="text" name="memberAddr" id="memberAddr" maxlength="40"
								placeholder="상세 주소를 입력하세요" required class="join-component">
							</c:if>						
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
							<label for="memberEmail">이메일</label>
						</div>
						<div class="join-input-item">
							<input type="email" id="memberEmail" name="memberEmail" class="join-component" placeholder="user@example.com">
							<button type="button" id="mailChkBtn" class="join-btn-primary">본인인증</button>
						</div>
						<p id="emailMessage" class="input-msg"></p>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="memberEmailCerti">이메일 인증</label>
						</div>
						<div class="join-input-item">
							<input type="text" name="memberEmailCerti" id="memberEmailCerti" placeholder="이메일 인증코드 입력" class="join-component" maxlength="6"><br>
							<div>
								<button type="button" id="mailChkWarn" class="join-btn-primary-chk">인증번호 확인</button>
							</div>
						</div>
						<div id="mailChkMessage" class="input-msg"></div>
					</div>	
					<div class="join-input-wrap">
						<label for="memberGender" class="join-input-title">성별</label>
						<div class="join-input-title">
							  <input type="radio" name="memberGender" value="0">남자
							  <input type="radio" name="memberGender" value="1">여자
							  <input type="radio" name="memberGender" value="2">비공개
						</div>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="portfolio">포트폴리오</label>
						</div>
						<div class="join-input-item">
							 <!-- 파일 입력 필드를 숨김 -->
					        <input type="file" id="portfolio" name="portfolio" class="join-component" style="display: none;" />
					        <!-- 커스텀 버튼 -->
					        <label for="portfolio" class="custom-file-button">파일 선택</label>
					        <span id="file-name" class="file-name">선택된 파일 없음</span>
						</div>
					</div>
					<div class="join-input-wrap">
						<div class="join-input-title">
							<label for="join-category">분류를 선택하세요</label>
								<div>
							        <label for="main_category">대분류</label>
							        <select id="main_category">
							            <option value="">선택하세요</option>
							        </select>
							    </div>
							    <div>
							        <label for="sub_category">중분류</label>
							        <select id="sub_category" disabled>
							            <option value="">선택하세요</option>
							        </select>
							    </div>
							    <div>
							        <label for="third_category">소분류</label>
							        <select id="third_category" name="thirdCategoryCd" disabled>
							            <option value="" >선택하세요</option>						     
							        </select>
							    </div>
					    </div>
					</div>
					<div class="join-button-box">
						<button type="submit" id="submitBtn" class="join-btn-primary lg" onclick="submitCom()">회원가입</button>
					</div>
				</form>
			</section>
		</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	$('#submitBtn').prop('disabled', true);
	
	document.getElementById('portfolio').addEventListener('change', function () {
	    const fileName = this.files[0] ? this.files[0].name : "선택된 파일 없음";
	    document.getElementById('file-name').textContent = fileName;
	});

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

	    // 인증번호 확인 버튼 클릭 시
	    $('#mailChkWarn').click(function() {
	        const enteredCode = $('#memberEmailCerti').val(); // 사용자가 입력한 인증번호
	        const $resultMsg = $('#mailChkMessage'); // 인증결과 메시지를 표시할 곳

	        if (enteredCode === sentCode) {
	            $resultMsg.html('인증번호가 일치합니다.').css('color', 'green');
	            $('#submitBtn').prop('disabled', false);  // 인증번호 일치하면 회원가입 버튼 활성화
	        } else {
	            $resultMsg.html('입력한 인증번호가 불일치 합니다. 다시 확인해주세요.').css('color', 'red');
	            $('#submitBtn').prop('disabled', true);  // 인증번호 불일치 시 회원가입 버튼 비활성화
	            alert('입력한 인증번호가 불일치 합니다. 다시 확인해주세요.');
	        }
	    });
	});
	
	const checkObj = {
		"memberId" : false,
		"idDuplChk" : false,
		"nickDuplChk" : false,
		"memberPw" : false,
		"memberPwConfirm" : false,
		"memberNickname" : false,
		"memberPhone" : false,		
		"portfolio" : false,
		"category" : false
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
            idMessage.html("영어 + 숫자 6~12글자 사이로 입력하세요").css('color', 'red');
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
                    msg("알림", "중복된 아이디가 존재합니다", "warning").css('color', 'red');
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
			nickMessage.html("한글,영어,숫자,특수문자 2~10글자 사이로 입력하세요").css('color', 'red')
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
					msg("알림", "중복된 닉네임이 존재합니다", "warning").css('color', 'red');
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
            pwMessage.html("비밀번호 형식이 유효하지 않습니다").css('color', 'red');
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
            pwMessage.html('비밀번호가 일치하지 않습니다').css('color', 'red');
            checkObj.memberPwConfirm = false;
        }
    });
    
    function checkPasswordMatch() {
        pwConfirmMessage.removeClass('valid invalid');

        if (memberPw.val() === memberPwConfirm.val()) {
            pwConfirmMessage.html("비밀번호가 일치합니다");
            pwConfirmMessage.addClass('valid');
            checkObj.memberPwConfirm = true;
        } else {
            pwConfirmMessage.html("비밀번호가 일치하지 않습니다").css('color', 'red');
            pwConfirmMessage.addClass('invalid');
            checkObj.memberPwConfirm = false;
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
			phoneMessage.html("전화번호 형식이 유효하지 않습니다").css('color', 'red');
			checkObj.memberPhone = false;
		}
	});
	function isAllTrue() {
	    return Object.values(checkObj).every(value => value === true);
	}
	
	function submitCom() {
	    const portfolioInput = document.getElementById('portfolio');
	    const fileName = document.getElementById('file-name');
	    
	    // 파일이 선택되지 않으면 경고 메시지 표시
	    if (portfolioInput.files.length === 0) {
	        alert("포트폴리오 파일을 선택해주세요.");
	        checkObj.portfolio = false;
	        return false;  // 파일이 선택되지 않으면 폼 제출을 막고 false 반환
	    } else {
	        // 파일이 선택되었다면 폼을 제출
	        checkObj.portfolio = true;
	        return true;  // 파일이 선택되면 폼을 정상적으로 제출
	    }
	}

	// 정보를 수정할 때마다 호출되는 함수
	function updateCheckObj(key, value) {
	    checkObj[key] = value;
	}
	
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
    const categories = {
    		"A0001": {
    	        "name": "취미",
    	        "categories": {
    	            "001_a0001": {
    	                "name": "악기",
    	                "subcategories": {
    	                    "A_001_a0001": "피아노",
    	                    "A_001_a0002": "보컬",
    	                    "A_001_a0003": "현악기",
    	                    "A_001_a0004": "관악기"
    	                }
    	            },
    	            "001_a0002": {
    	                "name": "스포츠",
    	                "subcategories": {
    	                    "A_001_a0005": "수상",
    	                    "A_001_a0006": "구기",
    	                    "A_001_a0007": "격투",
    	                    "A_001_a0008": "계절"
    	                }
    	            },
    	            "001_a0003": {
    	                "name": "연기",
    	                "subcategories": {
    	                    "A_001_a0009": "뮤지컬",
    	                    "A_001_a0010": "연기",
    	                    "A_001_a0011": "연출"
    	                }
    	            },
    	            "001_a0004": {
    	                "name": "미술",
    	                "subcategories": {
    	                    "A_001_a0012": "동양화",
    	                    "A_001_a0013": "서양화",
    	                    "A_001_a0014": "만화",
    	                    "A_001_a0015": "조소",
    	                    "A_001_a0016": "도예"
    	                }
    	            },
    	            "001_a0005": {
    	                "name": "생활",
    	                "subcategories": {
    	                    "A_001_a0017": "글쓰기",
    	                    "A_001_a0018": "낚시",
    	                    "A_001_a0019": "드론",
    	                    "A_001_a0020": "요리"
    	                }
    	            },
    	            "001_a0006": {
    	                "name": "사진/영상",
    	                "subcategories": {
    	                    "A_001_a0021": "사진촬영",
    	                    "A_001_a0022": "사진편집",
    	                    "A_001_a0023": "영상촬영",
    	                    "A_001_a0024": "영상편집"
    	                }
    	            }
    	        }
    	    },
    	    "A0002": {
    	        "name": "이사",
    	        "categories": {
    	            "002_b0001": {
    	                "name": "입주/집청소",
    	                "subcategories": {
    	                    "A_002_a0001": "청소",
    	                    "A_002_a0002": "이사",
    	                    "A_002_a0003": "시공"
    	                }
    	            },
    	            "002_b0002": {
    	                "name": "입주/사업장청소",
    	                "subcategories": {
    	                    "A_002_a0004": "청소",
    	                    "A_002_a0005": "이사",
    	                    "A_002_a0006": "시공"
    	                }
    	            },
    	            "002_b0003": {
    	                "name": "철거/폐기",
    	                "subcategories": {
    	                    "A_002_a0007": "철거",
    	                    "A_002_a0008": "폐기물처리"
    	                }
    	            }
    	        }
    	    },
    	    "A0003": {
    	        "name": "외주",
    	        "categories": {
    	            "003_c0001": {
    	                "name": "디자인",
    	                "subcategories": {
    	                    "A_003_a0001": "3D모델링",
    	                    "A_003_a0002": "애니메이션",
    	                    "A_003_a0003": "상업"
    	                }
    	            },
    	            "003_c0002": {
    	                "name": "개발",
    	                "subcategories": {
    	                    "A_003_a0004": "게임",
    	                    "A_003_a0005": "웹",
    	                    "A_003_a0006": "앱",
    	                    "A_003_a0007": "AI",
    	                    "A_003_a0008": "커머스"
    	                }
    	            },
    	            "003_c0003": {
    	                "name": "통번역",
    	                "subcategories": {
    	                    "A_003_a0009": "영어",
    	                    "A_003_a0010": "중국어",
    	                    "A_003_a0011": "일본어",
    	                    "A_003_a0012": "독일어",
    	                    "A_003_a0013": "기타언어"
    	                }
    	            },
    	            "003_c0004": {
    	                "name": "컨설팅",
    	                "subcategories": {
    	                    "A_003_a0014": "경영",
    	                    "A_003_a0015": "브랜딩",
    	                    "A_003_a0016": "창업",
    	                    "A_003_a0017": "크라우드펀딩"
    	                }
    	            }
    	        }
    	    },
    	    "A0004": {
    	        "name": "이벤트",
    	        "categories": {
    	            "004_d0001": {
    	                "name": "웨딩",
    	                "subcategories": {
    	                    "A_004_a0001": "사회자",
    	                    "A_004_a0002": "스드메",
    	                    "A_004_a0003": "주례",
    	                    "A_004_a0004": "축가",
    	                    "A_004_a0005": "장식"
    	                }
    	            },
    	            "004_d0002": {
    	                "name": "행사",
    	                "subcategories": {
    	                    "A_004_a0006": "댄스공연",
    	                    "A_004_a0007": "밴드공연",
    	                    "A_004_a0008": "마술공연",
    	                    "A_004_a0009": "MC",
    	                    "A_004_a0010": "STAFF",
    	                    "A_004_a0011": "경호"
    	                }
    	            }
    	        }
    	    },
    	    "A0005": {
    	        "name": "뷰티",
    	        "categories": {
    	            "005_e0001": {
    	                "name": "뷰티",
    	                "subcategories": {
    	                    "A_005_a0001": "퍼스널컬러",
    	                    "A_005_a0002": "네일",
    	                    "A_005_a0003": "관리",
    	                    "A_005_a0004": "헤어/메이크업"
    	                }
    	            }
    	        }
    	    },
    	    "A0006": {
    	        "name": "취업",
    	        "categories": {
    	            "006_f0001": {
    	                "name": "취업준비",
    	                "subcategories": {
    	                    "A_006_a0001": "면접컨설팅",
    	                    "A_006_a0002": "취업컨설팅",
    	                    "A_006_a0003": "자소서컨설팅",
    	                    "A_006_a0004": "포트폴리오컨설팅",
    	                    "A_006_a0005": "해외취업컨설팅"
    	                }
    	            },
    	            "006_f0002": {
    	                "name": "시험/자격증",
    	                "subcategories": {
    	                    "A_006_a0006": "간호사",
    	                    "A_006_a0007": "임용",
    	                    "A_006_a0008": "공무원",
    	                    "A_006_a0009": "사회복지사",
    	                    "A_006_a0010": "회계"
    	                }
    	            }
    	        }
    	    },
    	    "A0007": {
    	        "name": "과외",
    	        "categories": {
    	            "007_g0001": {
    	                "name": "과외",
    	                "subcategories": {
    	                    "A_007_a0001": "국어",
    	                    "A_007_a0002": "수학",
    	                    "A_007_a0003": "사회",
    	                    "A_007_a0004": "과학",
    	                    "A_007_a0005": "체대",
    	                    "A_007_a0006": "음대",
    	                    "A_007_a0007": "미대"
    	                }
    	            },
    	            "007_g0002": {
    	                "name": "유학",
    	                "subcategories": {
    	                    "A_007_a0008": "유학컨설팅",
    	                    "A_007_a0009": "ACT",
    	                    "A_007_a0010": "GMAT",
    	                    "A_007_a0011": "GRE",
    	                    "A_007_a0012": "LAST",
    	                    "A_007_a0013": "EJU"
    	                }
    	            }
    	        }
    	    },
    	    "A0008": {
    	        "name": "차량",
    	        "categories": {
    	            "008_h0001": {
    	                "name": "관리",
    	                "subcategories": {
    	                    "A_008_a0001": "세차",
    	                    "A_008_a0002": "수리",
    	                    "A_008_a0003": "오토바이",
    	                    "A_008_a0004": "튜닝"
    	                }
    	            },
    	            "008_h0002": {
    	                "name": "매매",
    	                "subcategories": {
    	                    "A_008_a0005": "중고",
    	                    "A_008_a0006": "신차",
    	                    "A_008_a0007": "리스/렌트",
    	                    "A_008_a0008": "캠핑카"
    	                }
    	            }
    	        }
    	    },
    	    "A0009": {
    	        "name": "금융/법률",
    	        "categories": {
    	            "009_i0001": {
    	                "name": "금융",
    	                "subcategories": {
    	                    "A_009_a0001": "보험설계",
    	                    "A_009_a0002": "암보험",
    	                    "A_009_a0003": "운전자보험",
    	                    "A_009_a0004": "자동차보험",
    	                    "A_009_a0005": "화재보험"
    	                }
    	            },
    	            "009_i0002": {
    	                "name": "법률",
    	                "subcategories": {
    	                    "A_009_a0006": "민사",
    	                    "A_009_a0007": "형사",
    	                    "A_009_a0008": "교통사고",
    	                    "A_009_a0009": "노동",
    	                    "A_009_a0010": "특허",
    	                    "A_009_a0011": "회생/파산"
    	                }
    	            },
    	            "009_i0003": {
    	                "name": "부동산",
    	                "subcategories": {
    	                    "A_009_a0012": "감정평가",
    	                    "A_009_a0013": "임대",
    	                    "A_009_a0014": "집사기",
    	                    "A_009_a0015": "집팔기",
    	                    "A_009_a0016": "전월세구하기",
    	                    "A_009_a0017": "전월세 내놓기"
    	                }
    	            }
    	        }
    	    }
    	};
    document.addEventListener('DOMContentLoaded', () => {
        const mainCategorySelect = document.getElementById('main_category');
        const subCategorySelect = document.getElementById('sub_category');
        const thirdCategorySelect = document.getElementById('third_category');

        // 대분류 추가
        for (const mainKey in categories) {
            const mainOption = document.createElement('option');
            mainOption.value = mainKey;
            mainOption.textContent = categories[mainKey].name;
            mainCategorySelect.appendChild(mainOption);
        }

        // 중분류 처리
        mainCategorySelect.addEventListener('change', () => {
            const selectedMainKey = mainCategorySelect.value;
            subCategorySelect.innerHTML = '<option value="">선택하세요</option>';
            thirdCategorySelect.innerHTML = '<option value="">선택하세요</option>';
            thirdCategorySelect.disabled = true;

            if (selectedMainKey) {
                const subCategories = categories[selectedMainKey].categories;
                for (const subKey in subCategories) {
                    const subOption = document.createElement('option');
                    subOption.value = subKey;
                    subOption.textContent = subCategories[subKey].name;
                    subCategorySelect.appendChild(subOption);
                }
                subCategorySelect.disabled = false;
            } else {
                subCategorySelect.disabled = true;
            }
        });

        // 소분류 처리
        subCategorySelect.addEventListener('change', () => {
            const selectedMainKey = mainCategorySelect.value;
            const selectedSubKey = subCategorySelect.value;
            thirdCategorySelect.innerHTML = '<option value="">선택하세요</option>';

            if (selectedSubKey) {
                const thirdCategories = categories[selectedMainKey].categories[selectedSubKey].subcategories;
                for (const thirdKey in thirdCategories) {
                    const thirdOption = document.createElement('option');
                    thirdOption.value = thirdKey;
                    thirdOption.textContent = thirdCategories[thirdKey];
                    thirdCategorySelect.appendChild(thirdOption);
                }
                thirdCategorySelect.disabled = false;
                checkObj.category = true;
            } else {
                thirdCategorySelect.disabled = true;
            }
        });
    });
    
 	// submit 버튼 클릭 시 실행되는 이벤트
	$('#submitBtn').click(function(event) {

	    // 모든 항목이 true인지 확인
	    if (isAllTrue()) {
	    	    alert('회원가입이 완료되었습니다.');
	    } else {
	    }
	});

    
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