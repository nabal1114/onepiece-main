const prices = document.getElementsByClassName("price");
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