const prices = document.getElementsByClassName("price");
const maxAmount = parseInt(document.getElementById("max-amount").textContent);
const productID = parseInt(document.getElementById("product-id").textContent);
const quantity = document.getElementById("quantity");
const tooltips = document.querySelectorAll(".product");

for (let price of prices) {
    const amount = parseFloat(price.textContent);

    price.textContent = formatCurrencyVND(amount);
}

tooltips.forEach(t => {
    new bootstrap.Tooltip(t);
});

function formatCurrencyVND(amount) {
    const formatter = new Intl.NumberFormat('ko-KR', {
        style: 'currency',
        currency: 'krw'
    });

    return formatter.format(amount);
}

quantity.addEventListener('input', function () {
    removeNonNumericCharacters(quantity);

    checkQuantity();
});

function removeNonNumericCharacters(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}

function increaseQuantity() {
    let currentQuantity = parseInt(quantity.value);

    quantity.value = currentQuantity + 1;

    checkQuantity();
}

function decreaseQuantity() {
    let currentQuantity = parseInt(quantity.value);

    quantity.value = currentQuantity - 1;

    checkQuantity();
}

function addToCart() {
    let currentQuantity = parseInt(quantity.value);

    let cartCookie = getCartCookie();

    if (cartCookie.hasOwnProperty(productID)) {
        if (cartCookie[productID] + currentQuantity <= maxAmount) {
            cartCookie[productID] += currentQuantity;
        }
        else {
            cartCookie[productID] = maxAmount;
        }
    } else {
        cartCookie[productID] = currentQuantity;
    }

    let expirationDate = new Date();
    expirationDate.setFullYear(expirationDate.getFullYear() + 1);

    let cartJson = JSON.stringify(cartCookie);

    document.cookie = 'cart=' + encodeURIComponent(cartJson) + '; expires=' + expirationDate.toUTCString();

    setTotalProductQuantityToCart();

    Toastify({
        text: '제품 ' + currentQuantity + '개가 장바구니에 담겼습니다.',
        position: 'right',
        gravity: 'bottom',
        duration: 3000,
        backgroundColor: '#000000'
    }).showToast();
}

function checkQuantity() {
    let currentQuantity = parseInt(quantity.value);

    if (currentQuantity < 1 || isNaN(currentQuantity)) {
        quantity.value = 1;
    }

    if (currentQuantity > maxAmount) {
        quantity.value = maxAmount;
    }
}

jQuery(document).ready(function () {
    jQuery(".ecommerce-gallery").lightSlider({
        gallery: true,
        item: 1,
        loop: true,
        thumbItem: 4,
        thumbMargin: 10
    });
});