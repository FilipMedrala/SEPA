var firebaseConfig = {
    apiKey: "AIzaSyDIR6Go8QoYic9psU4R_YRrfNp6e_HZQc4",
    authDomain: "test-62d52.firebaseapp.com",
    projectId: "test-62d52",
    storageBucket: "test-62d52.appspot.com",
    messagingSenderId: "790136710979",
    appId: "1:790136710979:web:1ac3789f5d8d038ca9f1f6"
};

firebase.initializeApp(firebaseConfig);
var user = firebase.auth().currentUser;
var list = document.getElementById("list");

firebase.auth().onAuthStateChanged(user => {
    if (user) {
        console.log("user= " + user.displayName)
        var hello = document.getElementById("hello")
        if (hello) {
            hello.innerHTML = "Hello " + user.displayName;
        }
        // If user logged in, add user options in nav bar
        list.children[3].style.display = "flex";
        list.children[4].style.display = "flex";
        list.children[5].style.display = "flex";

    } else {
        // If user not signed in, add login option 
        list.children[0].style.display = "flex";
    }
});        

function signOut() {
    firebase.auth().signOut().then(() => {
      console.log("sign out successful");
    // Sign-out successful.
    }).catch((error) => {
      // An error happened.
    });
  }

var signOutButton = document.getElementById("signOut");
signOutButton.addEventListener('click', signOut)