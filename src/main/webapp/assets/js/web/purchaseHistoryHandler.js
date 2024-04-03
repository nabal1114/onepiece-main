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

function handleDeletePurchaseHistory(id) {
    Swal.fire({
        title: "구매 내역 삭제?",
        text: "구매 내역을 삭제 하시겠습니까?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "삭제!",
        cancelButtonText: "취소!"
    }).then((result) => {
        if (result.isConfirmed) {
            const url = "purchase-history?id=" + id;

            $.ajax({
                url: url,
                type: "DELETE",
                dataType: "json",
                success: function (data) {
                    if (data.status === "success") {
                        Swal.fire({
                            title: "삭제 완료!",
                            text: "구매 내역이 삭제 되었습니다!",
                            icon: "success"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.reload();
                            }
                        });
                    } else {
                        Swal.fire({
                            title: "Oops...",
                            text: "오류 발생!",
                            icon: "error"
                        });
                    }
                },
                error: function () {
                    Swal.fire({
                        title: "Oops...",
                        text: "요청 중 오류 발생!",
                        icon: "error"
                    });
                }
            });
        }
    });
}