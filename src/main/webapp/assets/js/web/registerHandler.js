const form = document.getElementById('register-form');
const fullNameInput = document.getElementById('full-name');
const birthYearInput = document.getElementById('birth-year');
const genderInputs = document.querySelectorAll('input[name="gender"]');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('confirm-password');
const errorMessage = document.getElementById('error-message');


form.addEventListener('submit', function (event) {
    event.preventDefault();

    removeExtraSpaces(fullNameInput);

    const emailValue = emailInput.value;
    const passwordValue = passwordInput.value;

    if (isSelectedGender() === false) {
        errorMessage.textContent = '성별 골라!';
        return;
    }

    if (!isValidEmail(emailValue)) {
        errorMessage.textContent = '이메일 이상해!';
        emailInput.focus();
        return;
    }

    if (!isStrongPassword(passwordValue)) {
        errorMessage.textContent = '비밀번호는 6글자 이상! 숫자, 대문자, 특수문자 포함!';
        passwordInput.focus();
        return;
    }

    if (!isPasswordMatch(passwordValue, confirmPasswordInput.value)) {
        errorMessage.textContent = '비밀번호 일치 안한다!';
        confirmPasswordInput.focus();
        return;
    }

    this.submit();
});

birthYearInput.addEventListener('input', function () {
    removeNonNumericCharacters(birthYearInput);

    if (birthYearInput.value.length > 4) {
        birthYearInput.value = birthYearInput.value.slice(0, 4);
    }
});

emailInput.addEventListener('input', function () {
    removeSpaces(emailInput);
});

passwordInput.addEventListener('input', function () {
    removeSpaces(passwordInput);
});

confirmPasswordInput.addEventListener('input', function () {
    removeSpaces(confirmPasswordInput);
});

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function removeSpaces(input) {
    input.value = input.value.replace(/\s/g, '');
}

function removeExtraSpaces(input) {
    input.value = input.value.replace(/\s+/g, ' ').trim();
}

function removeNonNumericCharacters(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
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

function isSelectedGender() {
    let genderSelected = false;

    for (var i = 0; i < genderInputs.length; i++) {
        if (genderInputs[i].checked) {
            genderSelected = true;
            break;
        }
    }

    return genderSelected;
}


document.querySelectorAll('.show-password-toggle').forEach(function (eyeIcon) {
    eyeIcon.addEventListener('click', function () {
        const inputId = this.getAttribute('data-toggle');
        const passwordInput = document.getElementById(inputId);

        passwordInput.type = passwordInput.type === 'password' ? 'text' : 'password';

        // Toggle between the eye and eye-slash icons
        this.classList.toggle('fa-eye', !(passwordInput.type === 'password'));
        this.classList.toggle('fa-eye-slash', (passwordInput.type === 'password'));
    });
});
