<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/register.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>One Piece | Register</title>
    </head>
    <body>

        <div class="container main">
            <div class="register-container p-5">
                <header>회원 가입</header>
                <form id="register-form" action="register" method="post">
                    <div class="row">
                        <div class="col-lg-6 col-sm-12">
                            <div class="input-field">
                                <input name="full-name" type="text" class="input" id="full-name" required value="${fullName}">
                                <label for="full-name">이름</label>
                            </div>
                            <div class="input-field">
                                <input name="birth-year" type="text" class="input" id="birth-year" required value="${birthYear}">
                                <label for="birth-year">출생연도</label>
                            </div>

                            <div class="input-field-gender">
                                <label for="gender">성별</label>
                                <div class="m-1 p-1">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" id="male" value="male" ${gender eq 'male' ? 'checked' : ''}>
                                        <label class="form-check-label" for="male">
                                            남성
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" id="female" value="female" ${gender eq 'female' ? 'checked' : ''}>
                                        <label class="form-check-label" for="female">
                                            여성
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-sm-12">
                            <div class="input-field">
                                <input name="email" type="text" class="input" id="email" required value="${email}">
                                <label for="email">Email</label>
                            </div>

                            <div class="input-field eye">
                                <input name="password" type="password" class="input" id="password" required>
                                <label for="password">비밀번호</label>
                                <i class="show-password-toggle fas fa-eye-slash" data-toggle="password"></i>
                            </div>


                            <div class="input-field eye">
                                <input name="confirm-password" type="password" class="input" id="confirm-password" required>
                                <label for="confirm-password">비밀번호 확인</label>
                                <i class="show-password-toggle fas fa-eye-slash" data-toggle="confirm-password"></i>
                            </div>


                        </div>
                    </div>

                    <div class="input-field m-2" id="submit-form">
                        <input type="submit" class="submit" value="등록">
                        <div id="error-message" class="text-danger mt-3">${errorMsg}</div>
                    </div>

                    <div class="login">
                        <span>이미 계정이 있나요? <a href="login">로그인 하러가기</a></span>
                    </div>
                </form>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/registerHandler.js"></script>
    </body>
</html>