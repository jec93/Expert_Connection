<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>

/* 메인 콘텐츠 */
.main-content {
    flex: 1;
    display: flex;
    justify-content: space-evenly;
    align-items: flex-start; /* 위로 정렬 */
    padding: 10px 20px; /* 상단 패딩을 줄임 */
    gap: 0px; /* 두 박스 사이 간격 */
    margin-top: -20px; /* 콘텐츠 전체를 위로 당김 */
}

/* 선택 영역 스타일 */
.option-container {
    width: 35%;
    height: 350px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-color: #fff; /* 박스 배경은 흰색 */
    border: 2px solid #223B24; /* 주 컬러 테두리 */
    border-radius: 15px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
    position: relative; /* 아이콘 배치를 위해 */
}

.option-container:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    border-color: #7CBBAD; /* 호버 시 더 진한 주 컬러 */
}

/* 제목 스타일 */
.option-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

/* 설명 텍스트 */
.option-desc {
    font-size: 16px;
    color: #666;
    margin-bottom: 20px;
    padding: 0 20px;
    line-height: 1.6;
}

/* 페이지 설명 */
.page-desc {
    font-size: 18px;
    text-align: center;
    color: #555;
    margin-bottom: 40px;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <!-- 메인 콘텐츠 -->
    <div class="wrap">
        <div class="page-title">회원가입</div>
        <p class="page-desc">전문가와 함께하는 스마트한 선택, Expert Connection</p>
        <div class="main-content">
        
            <!-- 일반 회원 -->
            <div class="option-container">
                <div class="option-title">일반 회원 가입</div>
                <p class="option-desc">전문가를 만나는 가장 쉬운 방법! 지금 회원가입하고 특별한 연결을 시작하세요!</p>
                <a href="/member/joinFrm.exco" class="btn-primary">회원가입</a>
            </div>
            
            <!-- 전문가 -->
            <div class="option-container">
                <div class="option-title">전문가 회원가입</div>
                <p class="option-desc">전문가로서의 당신을 빛내줄 최고의 플랫폼, 지금 시작하세요!</p>
                <a href="/member/joinExpertFrm.exco" class="btn-primary">회원가입</a>
            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>
