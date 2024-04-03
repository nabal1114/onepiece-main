<footer class="bg-light p-1">
    <div class="container">
        <div class="row justify-content-between my-5 text-center">
            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12 py-1">
                <ul class="nav flex-column">
                    <li class="fw-bold nav-item">
                        <a href="home" class="nav-link text-dark">
                            카테고리
                        </a>
                    </li>
                    <c:forEach var="category" items="${Singleton.categoryDAO.getAll()}">
                        <li class="nav-item">
                            <a href="search?category_id=${category.ID}" class="nav-link text-muted">
                                ${category.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12 py-1">
                <ul class="nav flex-column">
                    <li class="fw-bold nav-item text-dark">
                        <a href="home" class="nav-link text-dark">HELP</a>
                    </li>
                    <li class="nav-item">
                        <a href="profile" class="nav-link text-muted">프로필</a>
                    </li>
                    <li class="nav-item">
                        <a href="cart" class="nav-link text-muted">장바구니</a>
                    </li>
                    <li class="nav-item">
                        <a href="purchase-history?tab=all" class="nav-link text-muted">구매 내역</a>
                    </li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12 py-1">
                <ul class="nav flex-column">
                    <li class="fw-bold nav-item text-dark">
                        <a href="home" class="nav-link text-dark">Social</a>
                    </li>
                    <li class="nav-item">
                        <a href="https://github.com/hardingadonis/miu-shop" target="_blank" class="nav-link text-muted">
                            <i class="fab fa-github"></i>
                            One Piece
                        </a>
                    </li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12 py-1">
                <ul class="nav flex-column">
                    <li class="fw-bold nav-item text-dark">
                        <a href="home" class="nav-link text-dark">정보</a>
                    </li>
                    <li class="nav-item">
                        <a href="about" class="nav-link text-muted">1팀 소개</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>