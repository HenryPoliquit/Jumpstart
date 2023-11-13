console.log("js connected");

//  ERROR MESSAGE TAG
const errorText = document.getElementById("error-text");

//  COLORS
const error = "#f65151";
const success = "#5cb85c";

// FIELD TAGS
const purchForm = document.getElementById("purchase");
const method = document.getElementById("method");
const currency = document.getElementById("currency");
const count = document.getElementById("count");
const amount = document.getElementById("amount");
const location = document.getElementById("location");

//REGEX
var numberRegex = /\d/;
var alphanumericRegex = /^([a-z]*\d[a-z0-9]*|[a-z]+\d+[a-z0-9]*){50,}$/i;
var alphabeticRegex = /^[A-Za-z\s]+$/;
var emailRegex = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-]+)(\.[a-zA-Z]{2,5}){1,2}$/;

//SHOW ERROR MESSAGE
let errorMessage = "";
function showErrorPopup() {
    errorText.innerText = errorMessage;
    $(".error-popup").css("visibility", "visible");
    $(".error-popup").fadeIn("fast");
    setTimeout(function () {
        $(".error-popup").fadeOut("fast");
    }, 15000);
}

//FORM SUBMIT VALIDATION
function validatePurchase(event) {
    // STOP FORM FROM BEING SUBMITTED
    event.preventDefault();

    // FULLNAME
    if (fullname.value.length < 3) {
        fullname.style.borderColor = error;
        errorMessage = "You name cannot be shorter than 3 characters";
        showErrorPopup();
        fullname.focus();
        return false;
    } else if (numberRegex.test(fullname.value)) {
        fullname.style.borderColor = error;
        errorMessage = "Your name cannot contain a number";
        showErrorPopup();
        fullname.focus();
        return false;
    }
    // USERNAME
    else if (username.value.length < 3) {
        username.style.borderColor = error;
        errorMessage = "Username cannot be shorter than 3 characters";
        showErrorPopup();
        username.focus();
        return false;
    }
    // EMAIL
    else if (!emailRegex.test(email.value)) {
        email.style.borderColor = error;
        errorMessage = "Please enter a valid email address";
        showErrorPopup();
        email.focus();
        return false;
    } 
    // PASSWORD
    else if (password.value.length < 5) {
        password.style.borderColor = error;
        errorMessage = "Please enter a password longer than 5 characters";
        showErrorPopup();
        password.focus();
        return false;
    }
    else if (!numberRegex.test(password.value)) {
        password.style.borderColor = error;
        errorMessage = "Please enter a password containing at least one number";
        showErrorPopup();
        password.focus();
        return false;
    }
    // FORM FULLY VALIDATED
    else {
        regForm.submit();
    }
}