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

var user = firebase.auth().currentUser;

// If logged in, redirect to homepage
firebase.auth().onAuthStateChanged(user => {
  if (user.displayName) {
     window.location.href = "dashboard.html";
  }
});

function signUpWithEmailPassword() {
  document.getElementById("signUp").style.display = "none";
  document.getElementById("loader").classList.add("loader");

  // Defines the sign up page error message box
  var page = 0;

  // Get new user details
  var userDisplayName = document.getElementsByClassName("displayName")[page].value;
  var email = document.getElementsByClassName("email")[page].value;
  var password = document.getElementsByClassName("password")[page].value;

  // [START auth_signup_password]
  // Throw an error if the display name is empty
  if(userDisplayName.length == 0) {
    errorText[page].innerHTML = "You must enter your name!";
    errorText[page].classList.add("error");
    focusError("displayName", page);
    removeLoader();
    return;
  }

  firebase.auth().createUserWithEmailAndPassword(email, password)
    .then((userCredential) => {
      // Signed in and set Display Name
      var user = userCredential.user;
      user.updateProfile({
        displayName: userDisplayName
      });
      setTimeout(function(){
        window.location.href = "dashboard.html";
      }, 1000);
      // ...
    })
    .catch((error) => {
      var errorCode = error.code;
      var errorMessage = error.message;
      console.log(errorCode);
      console.log(errorMessage);

      // Display error message
      errorMessages(page, errorCode);
      removeLoader();
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

  // Remove the loader and replace the submit button if an error occurs
  function removeLoader() {
    document.getElementById("signUp").style.display = "inline-block";
    document.getElementById("loader").classList.remove("loader");
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
        document.cookie = "userID=" + user.uid;
        console.log(user);
        window.location.href = "dashboard.html";
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

const forgotPassword = document.getElementById("forgotPasswordForm");
forgotPassword.addEventListener("submit", (e) => {
  e.preventDefault();
  sendPasswordResetEmail();
});

const signUp = document.getElementById("signUpForm");
signUp.addEventListener("submit", (e) => {
  e.preventDefault();
  signUpWithEmailPassword();
});

const signIn = document.getElementById("signInForm");
signIn.addEventListener("submit", (e) => {
  e.preventDefault();
  signInWithEmailPassword();
});
