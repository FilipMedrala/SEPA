
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
const errorText = document.getElementsByClassName("errorText"); // The error message box

function signUpWithEmailPassword() {
  // Get new user details
  var displayName = document.getElementById("displayName").value;
  var email = document.getElementById("newEmail").value;
  var password = document.getElementById("newPassword").value;

  // Defines the sign up page error message box
  var page = 0;

  // [START auth_signup_password]
  // Throw an error if the display name is empty
  if(displayName.length == 0) {
    errorText[page].innerHTML = "You must enter your name!";
    errorText[page].classList.add("error"); 
    focusError("displayName");
    return;
  }

  firebase.auth().createUserWithEmailAndPassword(email, password)
    .then((userCredential) => {
      // Signed in and set Display Name
      var user = userCredential.user;
      user.updateProfile({
        displayName: displayName,
      })
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
      focusError("newEmail");
    } else if(errorCode == "auth/weak-password") {
      errorText[page].innerHTML = "Your password is too weak!";
      focusError("newPassword");        
    } else if(errorCode == "auth/invalid-email") {
      errorText[page].innerHTML = "You must enter a valid email!";   
      focusError("newEmail"); 
      focusError("email");
    } else if(errorCode == "auth/wrong-password" || errorCode == "auth/user-not-found") {
      errorText[page].innerHTML = "The email or password you have entered is incorrect, please try again!";   
      focusError("newEmail"); 
      focusError("newPassword");
      focusError("password");
      focusError("email");
    } else {
      errorText[page].innerHTML = "Sorry, something went wrong! Please try again.";   
    }
    errorText[page].classList.add("error"); 
  }

  // Focus the curson on the input box and make it flash red
  function focusError(elementId) {
    element = document.getElementById(elementId)
    element.classList.add("flash");
    setTimeout(function(){
      element.classList.remove("flash");
    }, 1000); 
    element.focus();
    element.select();
  }

  function signInWithEmailPassword() {
    var email = document.getElementById('email').value;
    var password = document.getElementById('password').value;

    // Defines the sign in page error message box
    var page = 1;

    // Throw an error if the email or password is empty
    if(email.length > 0 && password.length == 0) {
      errorText[page].innerHTML = "You must enter your password!";
      errorText[page].classList.add("error"); 
      focusError("password");
      return;
    } else if(password.length == 0) {
      errorText[page].innerHTML = "You must enter your email and password!";
      errorText[page].classList.add("error"); 
      focusError("password");
      focusError("email");
      return;
    }

    // [START auth_signin_password]
    firebase.auth().signInWithEmailAndPassword(email, password)
      .then((userCredential) => {
        // Signed in
        var user = userCredential.user;
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

const signUpButton = document.getElementById('signUp');
signUpButton.addEventListener('click', signUpWithEmailPassword)

const signInButton = document.getElementById('signIn');
signInButton.addEventListener('click', signInWithEmailPassword)

const test = document.getElementById('test');
test.addEventListener('click', () => {
  const user = firebase.auth().currentUser;
  console.log(user)
	// user.updateProfile({
  //   displayName: "Jane Q. User",
  // })

});

const test2 = document.getElementById('test2');
test2.addEventListener('click', () => {
  const user = firebase.auth().currentUser;
  console.log(user)
	user.updateProfile({
    displayName: "Test User",
  })

});