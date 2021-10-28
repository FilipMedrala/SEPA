# Setting up Firebase
The user management system is handled entirely through Firebase Authentication. To set up your own, the only requirement is a personal Gmail account. 

## Creating an account and user database

 1. Navigate to https://firebase.google.com/.
 2. Click 'Get Started'.
 3. Sign in with your Gmail details.
 4. Once you have logged in, click 'Create a project'.
 5. Enter a project name such as *Fuzzing Platform*.
 6. Once the project has been created, open 'Authentication' from the Build menu on the left hand side.
 7. On the Authentication page, click 'Get Started'.
 8. From there, select 'Email/Password' from under the Sign-in providers banner and enable it before saving.
 9. Under the Authorized Domains banner, you can choose to add your websites domain or simply leave it as the default (localhost). By adding a domain here, you are whitelisting it so that Firebase Authentication will accept requests from any URL and port of that domain. This prevents others from using your credentials to create users unless they do so through your website.
 10. Under the Advanced banner, you have the option to set the sign-up quota to protect your project from abuse. The default value is set to 100 new email/password sign-ups from the same IP address each hour.

## Adding Firebase to your website

 1. On your 'Project Overview' page in Firebase, you should see the following phrase beneath your project's name "Get started by adding Firebase to your app". Underneath, click the Web icon which looks like </>
 2. Here you register your app by providing a name (this can be the same as your project) and click 'Register App'.
 3. In the second step titled 'Add Firebase SDK', check the 'Use a script tag' radio button.
 4. From the code block that appears, you will only need to copy the following:
    ```js
    const firebaseConfig =  {
        apiKey: "your-api-key",
        authDomain: "your-project-name.firebaseapp.com",
        projectId: "your-project-name",
        storageBucket: "your-project-name.appspot.com",
        messagingSenderId: "your-messaging-sender-id",
        appId: "your-app-Id"
    };
    ```
 5. Once you have your Firebase configuration details copied to your clipboard, navigate to the `firebase.js` file within the frontend HTML code. This can be found within the `assets\js` file path.
 6. At the very top of the document, replace the commented out firebase configuration with your own from your clipboard.



## Navigating the user database
On the Authentication page, navigate to 'Users' from the menu at the top. From here, you can view the following details about each user:
 - Identifier: The user's email address
 - Provider: This will be email
 - Created: The date the user's account was created
 - Signed In: The date the user last signed in
 - User UID: The unique identifier associated with the user and utilised to track their uploaded files in the back-end

From this page, you also have the following abilities for each user by hovering over their row and clicking 'View more options' on the left hand side:
 - Reset password
 - Disable account
 - Delete account

## Editing the 'Forgot Password' email 

 1. On the Authentication page, navigate to 'Templates' from the menu at the top.
 2. In the templates menu, open 'Password reset' on the left hand side.
 3. Press 'Edit template' at the top right-hand side.
 4. Scroll down to "Action URL (%LINK% value)" and click 'Customize action URL'
 5. From here, enter your domain name or localhost and ensure the link has `/reset.html` at the end. It should look like `http://127.0.0.1/reset.html`, `http://localhost/reset.html`or `http://<your-domain.com>/reset.html`. This will ensure that the password reset link sent to user's emails will be hosted through this website instead of Firebase. A randomly generated code will be automatically appended to the URL which verifies that each reset link can only be used once.
 6. On this page, you also have the option to customise the sender email to use your own domain, although this requires domain verification. You can also customise the email subject and body (which uses HTML), however, it will always require the reset password link which can be referenced with `<a href='%LINK%'>%LINK%</a>`
 7. You also have the option to use a custom SMTP server instead of the built-in email service by navigating to 'SMTP settings' in the left-hand side panel.

