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

        <title>One Piece | Checkout</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <div class="container">
            <div class="py-5 my-5">
                <div class="container">
                    <h6 class="display-6 mb-4 d-flex justify-content-center">
                        장바구니 결제
                    </h6>
                </div>

                <div class="px-5 m-5 border border-dark">
                    <form action="checkout" method="post" class="px-5">
                        <div class="mt-5">
                            <div class="d-flex justify-content-start align-items-center mx-5 my-3">
                                <h6 class="display-6 me-3">Total:</h6>
                                <h6 class="display-6 price" id="total-price">${total_price}</h6>
                            </div>

                            <div class="justify-content-start align-items-center mx-5 my-3">
                                <label for="address" class="form-label">배송지 주소</label>
                                <select id="address" name="address" class="form-select" required>
                                    <c:forEach var="address" items="${sessionScope.user.address}">
                                        <option value="${address}">${address}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="justify-content-start align-items-center mx-5 my-3">
                                <label for="payment" class="form-label">결제 방법</label>
                                <select id="payment" name="payment" class="form-select" required>
                                    <option value="cod">착불 결제</option>
                                    <option value="vnpay">카드 결제</option>
                                </select>
                            </div>

                            <c:if test="${sessionScope.user.address.size() > 0}">
                                <div class="my-4 text-center">
                                    <button type="submit" class="btn btn-outline-dark">결제</button>
                                </div>
                            </c:if>

                            <c:if test="${sessionScope.user.address.size() == 0}">
                                <div class="my-4 text-center">
                                    <a href="add-address" class="btn btn-outline-dark">배송지 주소 추가</a>
                                </div>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/checkoutHandler.js"></script>
    </body>

</html>