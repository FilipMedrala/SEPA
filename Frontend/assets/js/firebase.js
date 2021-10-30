/** Add your own personal firebase settings below **/
/** See /docs/FirebaseSetUp.md for steps **/

// const firebaseConfig =  {
//   apiKey: "your-api-key",
//   authDomain: "your-project-name.firebaseapp.com",
//   projectId: "your-project-name",
//   storageBucket: "your-project-name.appspot.com",
//   messagingSenderId: "your-messaging-sender-id",
//   appId: "your-app-Id"
// };

/** Initialize Firebase **/
firebase.initializeApp(firebaseConfig);

/** Parameters **/
const errorText = document.getElementsByClassName("errorText");
var user = firebase.auth().currentUser;

/** Sign up function **/
function signUpWithEmailPassword() {
  document.getElementById("signUp").style.display = "none";
  document.getElementById("loader").classList.add("loader");

  // Defines the sign up page error message box
  var page = 0;

  // Get new user details
  var userDisplayName = document.getElementsByClassName("displayName")[page].value;
  var email = document.getElementsByClassName("email")[page].value;
  var password = document.getElementsByClassName("password")[page].value;

  // Throw an error if the display name is empty
  if(userDisplayName.length == 0) {
    errorText[page].innerHTML = "You must enter your name!";
    errorText[page].classList.add("error");
    focusError("displayName", page);
    removeLoader();
    return;
  }

  // Throws an error if the password is weak
  if (!validatePassword(password)) {
    errorMessages(page, "auth/weak-password");
    removeLoader();
    return;
  }

  // Calls the Firebase sign up function
  firebase.auth().createUserWithEmailAndPassword(email, password)
    .then((userCredential) => {
      // Signs in and sets Display Name
      var user = userCredential.user;
      user.updateProfile({
        displayName: userDisplayName
      });

      // Waits for the display name to update then redirects to the dashboard
      setTimeout(function(){
        window.location.href = "dashboard.html";
      }, 1000);
    })
    .catch((error) => {
      var errorCode = error.code;

      // Displays error message
      errorMessages(page, errorCode);
      removeLoader();
    });
}

/** Validates the password strength **/
function validatePassword(password) {
  return (password.match(/[a-z]/g) && password.match(
    /[A-Z]/g) && password.match(
    /[0-9]/g) && password.match(
    /[^a-zA-Z\d]/g) && password.length >= 8)
}

/** Error Messages display function **/
function errorMessages(page, errorCode) {
  if(errorCode == "auth/email-already-in-use") {
    errorText[page].innerHTML = "An account with that email already exists!";
    focusError("email", page);
  } else if(errorCode == "auth/weak-password") {
    errorText[page].innerHTML = "Your password must contain at least 8 characters, one uppercase, one lowercase, one number and one special character!";
    focusError("password", page);
  } else if(errorCode == "auth/invalid-email") {
    errorText[page].innerHTML = "You must enter a valid email!";
    focusError("email", page);
  } else if(errorCode == "auth/wrong-password" || errorCode == "auth/user-not-found") {
    errorText[page].innerHTML = "The email or password you have entered is incorrect, please try again!";
    focusError("password", page);
    focusError("email", page);
  } else if(errorCode == "auth/invalid-action-code" || errorCode == "auth/expired-action-code") {
    errorText[page].innerHTML = "This reset link is no longer valid, please request a new one";
  } else if(errorCode == "unmatched-passwords") {
    errorText[page].innerHTML = "Your passwords do not match!";
    focusError("password", 1);
  } else {
    errorText[page].innerHTML = "Sorry, something went wrong! Please try again.";
  }
  errorText[page].classList.add("error");
}

/** Focuses the cursor on the input box that had an error and makes it flash red **/
function focusError(elementId, page) {
  var element = document.getElementsByClassName(elementId)[page];
  element.classList.add("flash");
  setTimeout(function(){
    element.classList.remove("flash");
  }, 1000);
  element.focus();
  element.select();
}

/** Removes the loader and replaces the submit button if an error occurs **/
function removeLoader() {
  document.getElementById("signUp").style.display = "inline-block";
  document.getElementById("loader").classList.remove("loader");
}

/** Sign In function **/
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

  // Calls the Firebase sign in function
  firebase.auth().signInWithEmailAndPassword(email, password)
    .then((userCredential) => {
      // Sets a cookie with the value of the user ID then redirects to the dashboard
      var user = userCredential.user;
      document.cookie = "userID=" + user.uid;
      window.location.href = "dashboard.html";
    })
    .catch((error) => {
      var errorCode = error.code;

      // Displays error message
      errorMessages(page, errorCode);
    });
}

/** Password reset email function **/
function sendPasswordResetEmail() {
  var page = 2;
  var email = document.getElementsByClassName("email")[page].value;

  // Calls the firebase password reset email function
  firebase.auth().sendPasswordResetEmail(email)
  .then(() => {
    // Password reset email sent!
    errorText[page].innerHTML = "An email has been sent to " + email + " with further instructions.";
    errorText[page].classList.add("error");
    errorText[page].style.color = "black";
    errorText[page].style.backgroundColor = "#e3e0e0";
  })
  .catch((error) => {
    var errorCode = error.code;

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
  });
}

/** Reset password function **/
function resetPassword() {
  var page = 0;

  // Gets the unique password reset code (only valid for one use)
  var url = window.location.href;
  var code = url.slice(url.search("&oobCode") + 9, url.search("&apiKey"));

  // Checks that the passwords entered match
  newPassword = document.getElementsByClassName("password")[0].value;
  confirmPassword = document.getElementsByClassName("password")[1].value;
  if (newPassword != confirmPassword) {
    errorMessages(page, "unmatched-passwords")
    return;
  }

  // Validates the password strength
  if (!validatePassword(newPassword)) {
    errorMessages(page, "auth/weak-password");
    return;
  }

  // Calls the firebase reset password function
  firebase.auth().confirmPasswordReset(code, newPassword)
  .then(function() {
    console.log("success!")
    const card = document.getElementById('card');
    card.classList.toggle("cardFlip");
  })
  .catch((error) => {
    var errorCode = error.code;

    // Through invalid reset code if user not found or disabled
    if (errorCode == "auth/user-not-found" || errorCode == "auth/user-disabled") {
      errorCode == "auth/invalid-action-code"
    }
    
    errorMessages(page, errorCode);
  })
}

/** Sign out function **/
function signOut() {
  firebase.auth().signOut().then(() => {
    console.log("sign out successful");
    // Sign-out successful.
  }).catch((error) => {
    // An error happened.
  });
}

/** Binds each function to the revelant buttons if they exist on the current page **/
const forgotPassword = document.getElementById("forgotPasswordForm");
if (typeof(forgotPassword) != 'undefined' && forgotPassword != null) {
  forgotPassword.addEventListener("submit", (e) => {
    e.preventDefault();
    sendPasswordResetEmail();
  });
}

const signUp = document.getElementById("signUpForm");
if (typeof(signUp) != 'undefined' && signUp != null) {
  signUp.addEventListener("submit", (e) => {
    e.preventDefault();
    signUpWithEmailPassword();
  });
}

const signIn = document.getElementById("signInForm");
if (typeof(signIn) != 'undefined' && signIn != null) {
  signIn.addEventListener("submit", (e) => {
    e.preventDefault();
    signInWithEmailPassword();
  });
}

const resetPasswordForm = document.getElementById("resetForm");
if (typeof(resetPasswordForm) != 'undefined' && resetPasswordForm != null) {
  resetPasswordForm.addEventListener("submit", (e) => {
    e.preventDefault();
    resetPassword();
  });
}

const signOutButton = document.getElementById("signOut");
if (typeof(signOutButton) != 'undefined' && signOutButton != null) {
  signOutButton.addEventListener('click', signOut)
}

/** On user sign in **/
firebase.auth().onAuthStateChanged(user => {
  // If logged in and on login/reset page, redirect to dashboard
  isLogin = document.getElementById("sign-in-container");
  if (typeof(isLogin) != 'undefined' && isLogin != null) {
    if (user && user.displayName) {
      window.location.href = "dashboard.html";
      console.log("login")
    }
  // Else, alter the nav bar links depending on login status
  } else {
    var list = document.getElementById("list");
    if (user) {
      var hello = document.getElementById("hello")
      if (hello) {
          hello.innerHTML = "Hello " + user.displayName;
      }
      // If user logged in, add user options in nav bar and remove sign in
      list.children[3].style.display = "flex";
      list.children[4].style.display = "flex";
      list.children[5].style.display = "flex";
    } else {
      list.children[0].style.display = "flex";
    }
  }
});