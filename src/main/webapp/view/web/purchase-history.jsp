<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/purchase-history.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>One Piece | Purchase history</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <section class="py-5 my-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-sm-12 text-center">
                        <img src="./${sessionScope.user.avatarPath}" alt="Avatar" class="img-thumbnail rounded">
                        <h3 class="my-4">${sessionScope.user.fullName}</h3>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a href="profile" class="nav-link text-muted option">프로필</a>
                                <a href="delivery-address" class="nav-link text-muted option">배송지 주소</a>
                                <a href="purchase-history?tab=all" class="nav-link text-muted option option-selected">구매 내역</a>
                                <a href="change-password" class="nav-link text-muted  option">비밀번호 변경</a>
                            </li>
                        </ul>
                    </div>

                    <div class="col-lg-9 col-sm-12">
                        <div class="container-fluid p-3 border border-dark">
                            <h6 class="m-3 text-center display-6">구매 내역</h6>

                            <div class="my-5">
                                <ul class="nav nav-tabs nav-fill mb-3">
                                    <li class="nav-item">
                                        <a class="nav-link ${param.tab eq 'all' ? 'text-dark fw-bold active' : 'text-black-50'}" href="purchase-history?tab=all">모두</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${param.tab eq 'processing' ? 'text-dark fw-bold active' : 'text-black-50'}" href="purchase-history?tab=processing">결제 중</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${param.tab eq 'shipping' ? 'text-dark fw-bold active' : 'text-black-50'}" href="purchase-history?tab=shipping">배송 중</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${param.tab eq 'done' ? 'text-dark fw-bold active' : 'text-black-50'}" href="purchase-history?tab=done">구매 완료</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${param.tab eq 'canceled' ? 'text-dark fw-bold active' : 'text-black-50'}" href="purchase-history?tab=canceled">취소 내역</a>
                                    </li>
                                </ul>

                                <div class="px-3 pt-3 border bg-light">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col" class="col-3 text-center">총액</th>
                                                <th scope="col" class="col-3 text-center">결제 방법</th>
                                                <th scope="col" class="col-3 text-center">상태</th>
                                                <th scope="col" class="col-3 text-center">작업</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${order_list}">
                                                <tr>
                                                    <td class="align-middle text-center price">${order.totalPrice}</td>
                                                    <td class="align-middle text-center">
                                                        <c:choose>
                                                            <c:when test="${order.payment.toString() eq 'cod'}">
                                                                <div class="text-white bg-indigo rounded-3">
                                                                    착불 결제
                                                                </div>
                                                            </c:when>
                                                            <c:when test="${order.payment.toString() eq 'vnpay'}">
                                                                <div class="text-white bg-teal rounded-3">
                                                                    카드 결제
                                                                </div>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td class="align-middle text-center">
                                                        <c:choose>
                                                            <c:when test="${order.status.toString() eq 'processing'}">
                                                                <div class="text-white bg-secondary rounded-3">
                                                                    결제 완료
                                                                </div>
                                                            </c:when>
                                                            <c:when test="${order.status.toString() eq 'shipping'}">
                                                                <div class="text-white bg-primary rounded-3">
                                                                    배송 중
                                                                </div>
                                                            </c:when>
                                                            <c:when test="${order.status.toString() eq 'done'}">
                                                                <div class="text-white bg-success rounded-3">
                                                                    배송 완료
                                                                </div>
                                                            </c:when>
                                                            <c:when test="${order.status.toString() eq 'canceled'}">
                                                                <div class="text-white bg-danger rounded-3">
                                                                    상품 취소
                                                                </div>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td class="align-middle text-center">
                                                        <a href="purchase-history-detail?id=${order.ID}" class="btn btn-sm btn-outline-dark">
                                                            <i class="fas fa-circle-info"></i>
                                                        </a>
                                                        <c:if test="${order.status.toString() eq 'processing'}">
                                                            <button class="btn btn-sm btn-outline-danger" onclick="handleDeletePurchaseHistory(${order.ID})">
                                                                <i class="fas fa-ban"></i>
                                                            </button>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="pt-4 pagination">
                                    <c:if test="${end_page > 1}">
                                        ${pagination_str}
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/purchaseHistoryHandler.js"></script>
    </body>
</html>