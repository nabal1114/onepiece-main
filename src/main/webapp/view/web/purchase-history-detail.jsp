<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/purchase-history-detail.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>One Piece | Purchase history detail</title>
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
                            <h6 class="m-3 text-center display-6">주문 상세정보</h6>

                            <div class="p-5">
                                <div class="row">
                                    <div class="col-lg-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">결제 방법:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${order.payment.toString() eq 'cod'}">
                                                            착불 결제
                                                        </c:when>
                                                        <c:when test="${order.payment.toString() eq 'vnpay'}">
                                                            카드 결제
                                                        </c:when>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">상태:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${order.status.toString() eq 'processing'}">
                                                            결제 완료
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'shipping'}">
                                                            배송 중
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'done'}">
                                                            배송 완료
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'canceled'}">
                                                            상품 취소
                                                        </c:when>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">주문 날짜:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p>${create_at_str}</p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">결제 금액:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p class="price">${order.totalPrice}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-2 col-sm-12">
                                            <p class="fw-bold">주소:</p>
                                        </div>
                                        <div class="col-lg-10 col-sm-12">
                                            <p>${order.address}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mt-4">
                                    <div class="col-lg-12 col-sm-12">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th scope="col" class="col-1 text-center">#</th>
                                                    <th scope="col" class="col-5 text-center">제품</th>
                                                    <th scope="col" class="col-2 text-center">단가</th>
                                                    <th scope="col" class="col-2 text-center">수량</th>
                                                    <th scope="col" class="col-2 text-center">합계</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="entry" items="${order_data}" varStatus="loop">
                                                    <tr>
                                                        <td class="align-middle text-center">${loop.index + 1}</td>
                                                        <td class="align-middle text-center">
                                                            <div class="product product-name">
                                                                <a href="product?id=${entry.key.ID}">
                                                                    ${entry.key.name}
                                                                </a></div>
                                                        </td>
                                                        <td class="align-middle text-center price">${entry.key.price}</td>
                                                        <td class="align-middle text-center">${entry.value}</td>
                                                        <td class="align-middle text-center price">${entry.key.price * entry.value}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                                <div class="row mt-4">
                                    <div class="col-lg-12 col-sm-12">
                                        <div class="d-flex justify-content-center">
                                            <c:if test="${not empty sessionScope.prevURL}">
                                                <a href="${sessionScope.prevURL}" class="btn btn-dark mx-1"><i class="fas fa-arrow-left"></i> 반품</a>
                                            </c:if>
                                            <c:if test="${order.status.toString() eq 'processing'}">
                                                <button type="button" class="btn btn-danger mx-1" onclick="handleDeletePurchaseHistory(${order.ID})"><i class="fas fa-ban"></i> 주문 취소</button>
                                            </c:if>
                                        </div>
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