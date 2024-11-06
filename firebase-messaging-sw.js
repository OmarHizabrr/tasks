// Import Firebase scripts required for messaging
importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js');

// Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyA8A2Z9lM9f7eXStO_2LRGIYyrT_ZVrpaE",
  authDomain: "socialledger-d0a40.firebaseapp.com",
  databaseURL: "https://socialledger-d0a40-default-rtdb.firebaseio.com",
  projectId: "socialledger-d0a40",
  storageBucket: "socialledger-d0a40.appspot.com",
  messagingSenderId: "3361259528",
  appId: "1:3361259528:web:a14ed888b110d85924d1bd"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// Retrieve Firebase Messaging instance to handle background messages
const messaging = firebase.messaging();

// Background message handler
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);

  // Customize notification here
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/firebase-logo.png' // يمكنك استبدال هذا بالمسار إلى أيقونة الإشعارات الخاصة بك
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
