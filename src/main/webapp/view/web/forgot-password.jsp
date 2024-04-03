<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/forgot-password.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>One Piece | Find password</title>
    </head>
    <body>

        <c:if test="${empty param.sent}">
            <div class="container main">
                <div class="forgot-password-container p-5">
                    <header>비밀번호 찾기</header>

                    <form id="forgot-password-form" action="forgot-password" method="post">
                        <div class="mb-5 mx-5 px-2">
                            <label for="email" class="form-label">Email</label>
                            <input name="email" type="text" class="form-control" id="email" required>
                        </div>

                        <div class="m-2" id="submit-form" style="display: flex; flex-direction: column; position: relative; padding: 0 10px;">
                            <input type="submit" class="submit" value="확인">
                            <div id="error-message" class="text-danger mt-3">${errorMsg}</div>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty param.sent}">
            <div class="container main">
                <div class="forgot-password-container p-5">
                    <header>비밀번호 찾기</header>

                    <div class="mb-5 mx-5 px-2">
                        <p class="form-label text-center">
                            비밀번호 변경 메일이 발송 되었습니다. Email을 확인 해주세요!
                        </p>
                    </div>
                </div>
            </div>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/forgotPasswordHandler.js"></script>
    </body>
</html>