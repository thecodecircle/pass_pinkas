import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (Notification.permission === 'granted') {
      navigator.serviceWorker.ready.then(function(registration) {
        registration.showNotification('קשל"פ', {
          body: data,
          vibrate: [200, 100, 200, 100, 200, 100, 200],
          tag: 'Kashlapp'
        });
      });
      // var title = 'Push Notification'
      // var body = data
      // var options = { body: body }
      // new Notification(title, options)
    }
  }
});


// navigator.serviceWorker.register('sw.js');
//
// function showNotification() {
//   Notification.requestPermission(function(result) {
//     if (result === 'granted') {
//
//     }
//   });
// }
