<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>
/* 기본 스타일 */


.wait-content-header {
    text-align: center;
    margin-bottom: 30px;
}

#wait-siteIntro-header {
    max-width: 300px;
    margin: 0 auto;
    display: block;
    margin-bottom: 15px;
}

.wait-content-header h6 {
    font-size: 18px;
    font-weight: normal;
    color: #555;
    margin-top: 10px;
}

/* 안내 사항 본문 스타일 */
.wait-content-body {
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.wait-content-body h6 {
    font-size: 22px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

.wait-content-body p {
    font-size: 16px;
    line-height: 1.6;
    color: #555;
    margin-bottom: 20px;
}

.wait-content-body ul {
    padding-left: 20px;
    margin-bottom: 20px;
}

.wait-content-body ul li {
    font-size: 16px;
    line-height: 1.6;
    color: #333;
    margin-bottom: 10px;
}

.wait-content-body ul li::before {
    content: "•";
    color: #4CAF50;
    margin-right: 10px;
}

.wait-content-body p:last-child {
    margin-bottom: 0;
}

/* 반응형 스타일 (가장 작은 화면 크기부터) */
@media (max-width: 768px) {
    .page-title {
        font-size: 28px;
    }

    .wait-content-header h6 {
        font-size: 16px;
    }

    .wait-content-body {
        padding: 20px;
    }

    .wait-content-body h6 {
        font-size: 18px;
    }

    .wait-content-body p {
        font-size: 14px;
    }

    .wait-content-body ul li {
        font-size: 14px;
    }
}

</style>
</head>
<body>
<div class="wrap">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <main class="content">
        <section class="section wait-list-wrap">
            <div class="list-body">
                <div class="list-content">
                    <div class="page-title">전문가 가입 안내사항</div>
                    <div class="wait-content-header">
                        <img id="wait-siteIntro-header" src="/resources/logo/expert_connection_logo_h_01.png">
                        <h5>Expert Connection을 이용하는 전문가 회원님들을 위한 안내사항입니다.</h5>
                    </div>
                    <div class="wait-content-body">
                        <p>회원가입이 완료된 후, 전문가는 관리자의 승인을 기다려야 합니다. 관리자는 제출된 포트폴리오와 관련 자료를 검토하여 전문가로서의 자격을 확인합니다. 만약 제출된 포트폴리오가 부족하거나 추가 자료가 필요하다고 판단될 경우, 관리자는 해당 전문가에게 이메일을 통해 추가 서류 제출을 요청할 수 있습니다. 전문가님께서는 추가 자료를 신속하게 제공해 주셔야 승인 절차가 원활하게 진행될 수 있습니다. 이후 모든 제출된 자료가 검토되면, 승인이 완료되고 전문가로서 활동이 가능해집니다.</p>
                        <br>
                        <p>요청 될 수 있는 자료</p>
                        <ul>
                            <li>포트폴리오</li>
                            <li>사업자등록증</li>
                            <li>사업계획서</li>
                            <li>자격증</li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

</html>