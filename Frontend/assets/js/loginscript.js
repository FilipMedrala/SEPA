// Login page javaScript document

// define constants
const card = document.getElementById('card');
const signInForm = document.getElementById('signInForm');
const signUpForm = document.getElementById('signUpForm');
const forgotPasswordForm = document.getElementById('forgotPasswordForm');
const signUpContainer = document.getElementById("sign-up-container");
const ForgotPasswordContainer = document.getElementById("forgot-password-container");

// card flip
function flip(container) {
	// change visibility of one side
	if (container.id == "signUpFlip") {
		ForgotPasswordContainer.style.visibility = "hidden";
	}
	else if (container.id == "forgotPasswordFlip") {
		signUpContainer.style.visibility = "hidden";
	}
	card.classList.toggle("cardFlip");
	setTimeout(function(){
		// clear all form input and reset error messages
		signInForm.reset();
		signUpForm.reset();
		forgotPasswordForm.reset();
		resetErrorMessages();
		// revert visibility changes
		if (container.classList == "signInFlip") {
			ForgotPasswordContainer.style.visibility = "visible";
			signUpContainer.style.visibility = "visible";
		}
	}, 400);
};

// clear all error messages
function resetErrorMessages() {
	var errorText = document.getElementsByClassName("errorText");
	for(let i = 0; i < errorText.length; i++) {
		errorText[i].innerHTML = "";
		errorText[i].classList.remove("error"); 
	};  
}