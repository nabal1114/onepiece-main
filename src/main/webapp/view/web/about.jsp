<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>One Piece | About</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <section class="py-5 my-5">
            <div class="container">
                <div class="row py-3">
                    <div class="col-lg-6 col-md-12 py-1">
                        <h6 class="display-6 mb-4">
                            1팀 프로젝트
                        </h6>
                        <p>
                            김영채
                        </p>
                        <p>
                            김민성
                        </p>
                        <p>
                            김현준
                        </p>
                        <p>
                            선우준혁
                        </p>
                    </div>
                    <div class="col-lg-6 col-md-12 py-1">
                        <img class="card-img" src="<%=request.getContextPath()%>/assets/images/covers/55a08ee47df7b628ad07def611869c29dfba92dba3c803a5ff70dd88608817ca.avif">
                    </div>
                </div>
                <div class="py-3 text-center justify-content-center position-relative">
                    <h6 class="display-6 mb-4 mt-4">
                        할 수 있겠...지?
                    </h6>

                    <a href="https://github.com/hardingadonis/miu-shop/graphs/contributors" target="_blank">
                        <img src="https://contrib.rocks/image?repo=hardingadonis/miu-shop" />
                    </a>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
    </body>

</html>