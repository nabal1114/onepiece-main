const changePasswordForm = document.getElementById('change-password-form');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('comfirm-password');
const errorMessage = document.getElementById('error-message');

if (changePasswordForm) {
    changePasswordForm.addEventListener('submit', function (event) {
        event.preventDefault();

        if (!isStrongPassword(passwordInput.value)) {
            errorMessage.textContent = '비밀번호는 6글자 이상! 숫자, 대문자, 특수문자 포함!';
            passwordInput.focus();
            return;
        }

        if (!isPasswordMatch(passwordInput.value, confirmPasswordInput.value)) {
            errorMessage.textContent = '비밀번호 일치 안한다!';
            confirmNewPasswordInput.focus();
            return;
        }

        const url = 'forgot-change-password?email=' + emailInput.textContent + '&password=' + passwordInput.value;

        $.ajax({
            url: url,
            type: "POST",
            dataType: "json",
            success: function (data) {
                if (data && data.status === "success") {
                    Swal.fire({
                        title: "성공!",
                        text: "비밀번호 변경 성공!",
                        icon: "success"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'login';
                        }
                    });
                } else {
                    Swal.fire({
                        title: "실패!",
                        text: "비밀번호 변경 실패!",
                        icon: "error"
                    });
                }
            },
            error: function () {
                Swal.fire({
                    title: "실패!",
                    text: "실행 중 문제 발생! 다시 시도하세요!",
                    icon: "error"
                });
            }
        });

    });

    $(".toggle-password").click(function () {
        $(this).toggleClass("fa-eye fa-eye-slash");
        input = $(this).parent().find("input");

        if (input.attr("type") == "password") {
            input.attr("type", "text");
        } else {
            input.attr("type", "password");
        }
    });
}

passwordInput.addEventListener('input', function () {
    removeSpaces(passwordInput);
});

confirmPasswordInput.addEventListener('input', function () {
    removeSpaces(confirmPasswordInput);
});

function removeSpaces(input) {
    input.value = input.value.replace(/\s/g, '');
}

function isPasswordMatch(password, confirmPassword) {
    return password === confirmPassword;
}

function isStrongPassword(password) {
    if (password.length < 6) {
        return false;
    }

    if (!/\d/.test(password)) {
        return false;
    }

    if (!/[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]/.test(password)) {
        return false;
    }

    if (!/[A-Z]/.test(password)) {
        return false;
    }

    return true;
}
