// JavaScript Document


// card flip
const signUpFlip = document.getElementById('signUpFlip');
const signInFlip = document.getElementById('signInFlip');
const card = document.getElementById('card');
const signInForm = document.getElementById('signInForm');
const signUpForm = document.getElementById('signUpForm');

signUpFlip.addEventListener('click', () => {
	card.classList.toggle("cardFlip");
	setTimeout(function(){
		signInForm.reset();
	}, 400); 
});

signInFlip.addEventListener('click', () => {
	card.classList.toggle("cardFlip");
	setTimeout(function(){
		signUpForm.reset();
	}, 400); 
});