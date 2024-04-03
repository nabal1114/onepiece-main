const prices = document.getElementsByClassName("price");

for (let price of prices) {
    const amount = parseFloat(price.textContent);

    price.textContent = formatCurrencyVND(amount);
}

function formatCurrencyVND(amount) {
    const formatter = new Intl.NumberFormat('ko-KR', {
        style: 'currency',
        currency: 'krw'
    });

    return formatter.format(amount);
}