importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyDP4V_HFc51hpfW6onG8a-CPg2z0Ae7KSY",
    authDomain: "renat-bakaiev-site-b7b40.firebaseapp.com",
    projectId: "renat-bakaiev-site-b7b40",
    storageBucket: "renat-bakaiev-site-b7b40.appspot.com",
    messagingSenderId: "735151504836",
    appId: "1:735151504836:web:864e4014b23b868edd3891"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});

