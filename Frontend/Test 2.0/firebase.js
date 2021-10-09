
var firebaseConfig = {
  apiKey: "AIzaSyDIR6Go8QoYic9psU4R_YRrfNp6e_HZQc4",
  authDomain: "test-62d52.firebaseapp.com",
  projectId: "test-62d52",
  storageBucket: "test-62d52.appspot.com",
  messagingSenderId: "790136710979",
  appId: "1:790136710979:web:1ac3789f5d8d038ca9f1f6"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// Constants
const errorText = document.getElementsByClassName("errorText");

function signUpWithEmailPassword() {
  // Defines the sign up page error message box
  var page = 0;

  // Get new user details
  var displayName = document.getElementsByClassName("displayName")[page].value;
  var email = document.getElementsByClassName("email")[page].value;
  var password = document.getElementsByClassName("password")[page].value;

  // [START auth_signup_password]
  // Throw an error if the display name is empty
  if(displayName.length == 0) {
    errorText[page].innerHTML = "You must enter your name!";
    errorText[page].classList.add("error");
    focusError("displayName", page);
    return;
  }

  firebase.auth().createUserWithEmailAndPassword(email, password)
    .then((userCredential) => {
      // Signed in and set Display Name
      var user = userCredential.user;
      user.updateProfile({
        displayName: displayName
      });
      // ...
    })
    .catch((error) => {
      var errorCode = error.code;
      var errorMessage = error.message;
      console.log(errorCode);
      console.log(errorMessage);

      // Display error message
      errorMessages(page, errorCode);
      // ..
    });
    // [END auth_signup_password]
  }

  // Error Messages
  function errorMessages(page, errorCode) {
    if(errorCode == "auth/email-already-in-use") {
      errorText[page].innerHTML = "An account with that email already exists!";
      focusError("email", page);
    } else if(errorCode == "auth/weak-password") {
      errorText[page].innerHTML = "Your password is too weak!";
      focusError("password", page);
    } else if(errorCode == "auth/invalid-email") {
      errorText[page].innerHTML = "You must enter a valid email!";
      focusError("email", page);
    } else if(errorCode == "auth/wrong-password" || errorCode == "auth/user-not-found") {
      errorText[page].innerHTML = "The email or password you have entered is incorrect, please try again!";
      focusError("password", page);
      focusError("email", page);
    } else {
      errorText[page].innerHTML = "Sorry, something went wrong! Please try again.";   
    }
    errorText[page].classList.add("error");
  }

  // Focus the curson on the input box and make it flash red
  function focusError(elementId, page) {
    var element = document.getElementsByClassName(elementId)[page];
    element.classList.add("flash");
    setTimeout(function(){
      element.classList.remove("flash");
    }, 1000);
    element.focus();
    element.select();
  }

  function signInWithEmailPassword() {
    // Defines the sign in page error message box
    var page = 1;

    var email = document.getElementsByClassName("email")[page].value;
    var password = document.getElementsByClassName("password")[page].value;

    // Throw an error if the email or password is empty
    if(email.length > 0 && password.length == 0) {
      errorText[page].innerHTML = "You must enter your password!";
      errorText[page].classList.add("error");
      focusError("password", page);
      return;
    }
    if(password.length == 0) {
      errorText[page].innerHTML = "You must enter your email and password!";
      errorText[page].classList.add("error");
      focusError("password", page);
      focusError("email", page);
      return;
    }

    // [START auth_signin_password]
    firebase.auth().signInWithEmailAndPassword(email, password)
      .then((userCredential) => {
        // Signed in
        var user = userCredential.user;
        console.log(user);
        window.location.href = "index.html";
        // ...
      })
      .catch((error) => {
        var errorCode = error.code;
        var errorMessage = error.message;
        console.log(errorCode);
        console.log(errorMessage);
         // Display error message
        errorMessages(page, errorCode);
      // ..
      });
    // [END auth_signin_password]
  }

function sendPasswordResetEmail() {
  var page = 2;
  var email = document.getElementsByClassName("email")[page].value;
  firebase.auth().sendPasswordResetEmail(email)
  .then(() => {
    // Password reset email sent!
    errorText[page].innerHTML = "An email has been sent to " + email + " with further instructions.";
    errorText[page].classList.add("error");
    errorText[page].style.color = "black";
    errorText[page].style.backgroundColor = "#e3e0e0";
    // ..
  })
  .catch((error) => {
    var errorCode = error.code;
    var errorMessage = error.message;
    console.log(errorCode);
    console.log(errorMessage);
    // To prevent malicious actors from knowing which accounts exist
    if (errorCode == "auth/user-not-found") {
      errorText[page].innerHTML = "An email has been sent to " + email + " with further instructions.";
      errorText[page].style.color = "black";
      errorText[page].style.backgroundColor = "#e3e0e0";
    } else if(errorCode == "auth/invalid-email") {
      errorText[page].innerHTML = "You must enter a valid email!";
      focusError("email", page);
    }
    errorText[page].classList.add("error");
    // ..
  });
}

const forgotPasswordButton = document.getElementById("forgotPassword");
forgotPasswordButton.addEventListener("click", sendPasswordResetEmail);

const signUpButton = document.getElementById("signUp");
signUpButton.addEventListener("click", signUpWithEmailPassword);

const signInButton = document.getElementById("signIn");
signInButton.addEventListener("click", signInWithEmailPassword);
