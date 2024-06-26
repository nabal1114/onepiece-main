<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="io.hardingadonis.miu.model.Product"%>
<%@page import="io.hardingadonis.miu.model.Order"%>
<%@page import="io.hardingadonis.miu.model.OrderData"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <c:if test="${empty param.vnp_ResponseCode or param.vnp_ResponseCode eq '00'}">
            <title>One Piece | Checkout success</title>
            <%
                Order order = (Order) session.getAttribute("order");
                String cartCookie = (String) session.getAttribute("cart_cookie");
                int orderID = Singleton.orderDAO.insert(order);

                try {
                    JSONObject data = (JSONObject) new JSONParser().parse(cartCookie);

                    for (Object keyStr : data.keySet()) {
                        Object valueStr = data.get(keyStr);
                        int value = Integer.parseInt(valueStr.toString());
                        int key = Integer.parseInt(keyStr.toString());

                        Singleton.orderDataDAO.insert(new OrderData(orderID, key, value));

                        Product product = Singleton.productDAO.get(key);
                        product.setAmount(product.getAmount() - value);

                        Singleton.productDAO.update(product);
                    }

                    Cookie cookie = new Cookie("cart", "");
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                } catch (ParseException ex) {
                    System.err.println(ex.getMessage());
                }

                session.setAttribute("order", null);
                session.setAttribute("cart_cookie", null);
            %>
            <div class="container">
                <div class="py-5 my-5">
                    <div class="container my-5">
                        <h6 class="display-6 mb-4 d-flex justify-content-center">
                            결제 성공
                        </h6>
                        <br>
                        <br>
                        <div class="d-flex justify-content-center">
                            <a href="purchase-history?tab=all" class="btn btn-outline-dark">구매 내역으로 이동</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty param.vnp_ResponseCode and param.vnp_ResponseCode ne '00'}">
            <title>One Piece | Checkout failure</title>
            <%
                session.setAttribute("order", null);
            %>
            <div class="container">
                <div class="py-5 my-5">
                    <div class="container my-5">
                        <h6 class="display-6 mb-4 d-flex justify-content-center">
                            결제 실패
                        </h6>
                        <br>
                        <br>
                        <div class="d-flex justify-content-center">
                            <a href="cart" class="btn btn-outline-dark">장바구니로 돌아가기</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/checkoutHandler.js"></script>
    </body>

</html>